import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:moreway/core/api/api.dart';
import 'package:moreway/core/api/api_client.dart';
import 'package:moreway/module/auth/data/mapping/signin_data_model.dart';
import 'package:moreway/module/auth/data/mapping/signup_data_model.dart';
import 'package:moreway/module/auth/domain/dependency/i_auth_service.dart';
import 'package:moreway/module/auth/domain/entity/signin_data.dart';
import 'package:moreway/module/auth/domain/entity/signup_data.dart';
import 'package:moreway/module/auth/domain/entity/token.dart';
import 'package:moreway/module/user/domain/entity/user_profile.dart';
import 'package:moreway/module/auth/domain/exception/auth_exception.dart';
import 'package:moreway/module/user/data/mapping/user_me_model.dart';

class AuthServiceAPI implements IAuthService {
  final ApiClient _client;

  AuthServiceAPI(this._client);

  @override
  Future<Token> signIn(SignInData data) async {
    final signInDataModel =
        SignInDataModel(email: data.email, password: data.password);
    try {
      final response =
          await _client.dio.post(Api.loginUrl, data: signInDataModel.toJson());
      final tokenString = response.data["data"]["accessToken"];
      return Token(tokenString as String);
    } on DioException catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.dio.post(Api.logoutUrl);
    } on DioException catch (e) {
      throw _handleException(e);
    }
  }

  @override
  Future<Token> signUp(SignUpData data) async {
    final signUpDataModel = SignUpDataModel(
        name: data.name, email: data.email, password: data.password);
    try {
      await _client.dio.post(Api.registerUrl, data: signUpDataModel.toJson());
      final signInData = SignInData(email: data.email, password: data.password);
      return await signIn(signInData);
    } on DioException catch (e) {
      throw _handleException(e);
    }
  }

  AuthException _handleException(DioException e) {
    switch (e.type) {
      case DioExceptionType.badResponse:
        switch (e.response!.statusCode) {
          case 401:
          case 404:
            return const AuthException(
                message: "Неправильная почта или пароль");
          case 500:
            return const AuthException(message: "Сервер помер 💀");
          default:
            return const AuthException(
                message: "Неправильная почта или пароль");
        }
      default:
        return const AuthException(message: "Что-то сломалось :(");
    }
  }
}
