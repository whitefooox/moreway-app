import 'dart:developer';

import 'package:moreway/core/case/future_usecase.dart';
import 'package:moreway/module/auth/domain/dependency/i_auth_service.dart';
import 'package:moreway/module/auth/domain/dependency/i_token_manager.dart';
import 'package:moreway/module/auth/domain/entity/signup_data.dart';

class SignUpUseCase implements FutureUseCase<SignUpData, void> {

  final IAuthService _authService;
  final ITokenManager _tokenManager;

  SignUpUseCase(
    this._authService,
    this._tokenManager
  );

  @override
  Future<void> call(SignUpData input) async {
    try {
      final token = await _authService.signUp(input);
      _tokenManager.save(token);
    } catch (e) {
      log("[sign up use case] $e");
      rethrow;
    }
  }
}