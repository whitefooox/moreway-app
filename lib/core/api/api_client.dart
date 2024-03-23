import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:moreway/core/api/auth_interceptor.dart';
import 'package:moreway/module/auth/domain/dependency/i_token_storage.dart';

void setupApiClient(ITokenStorage tokenStorage, Dio dio) {
  dio.interceptors.add(CurlLoggerDioInterceptor());
  dio.interceptors.add(AuthInterceptor(tokenStorage, dio));
}