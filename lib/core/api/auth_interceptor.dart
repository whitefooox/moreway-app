import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:moreway/core/api/api.dart';
import 'package:moreway/module/auth/domain/dependency/i_token_storage.dart';
import 'package:moreway/module/auth/domain/entity/token.dart';

class AuthInterceptor extends Interceptor {
  final ITokenStorage _tokenStorage; 
  final Dio _dio;

  AuthInterceptor(this._tokenStorage, this._dio);

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenStorage.get();
    if (token != null) {
      options.headers["Authorization"] = "Bearer ${token.accessToken}";
      options.contentType = Headers.jsonContentType;
      options.headers["Accept"] = "application/json";
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await _refreshToken();
      RequestOptions options = err.requestOptions;
      final opts = Options(
        method: err.requestOptions.method,
        headers: err.requestOptions.headers);
      final req = await _dio.request(
        options.path,
        options: opts,
        queryParameters: err.requestOptions.queryParameters
      );
      return handler.resolve(req);
    } else {
      log(err.response!.data);
    }
  }

  Future<void> _refreshToken() async {
    try {
      final response = await _dio.post(Api.refreshToken);
      final tokenString = response.data["data"]["accessToken"];
      _tokenStorage.save(Token(tokenString as String));
    } catch (e) {
      log(e.toString());
    }
  }
}