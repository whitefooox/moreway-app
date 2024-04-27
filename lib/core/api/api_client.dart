import 'package:dio/dio.dart';
import 'package:moreway/core/api/api.dart';
import 'package:moreway/core/api/auth_interceptor.dart';
import 'package:moreway/module/auth/domain/dependency/i_token_storage.dart';

void setupApiClient(ITokenStorage tokenStorage, Dio dio) {
  dio.interceptors.add(AuthInterceptor(tokenStorage, dio));

  dio.options = BaseOptions(baseUrl: Api.baseUrl);
}
