import 'dart:developer';

import 'package:moreway/core/case/future_usecase.dart';
import 'package:moreway/module/auth/domain/dependency/i_auth_service.dart';
import 'package:moreway/module/auth/domain/dependency/i_token_storage.dart';
import 'package:moreway/module/auth/domain/entity/signup_data.dart';

class SignUpUseCase implements FutureUseCase<SignUpData, void> {

  final IAuthService _authService;
  final ITokenStorage _tokenStorage;

  SignUpUseCase(
    this._authService,
    this._tokenStorage
  );

  @override
  Future<void> call(SignUpData input) async {
    try {
      final token = await _authService.signUp(input);
      _tokenStorage.save(token);
    } catch (e) {
      log("[sign up use case] $e");
      rethrow;
    }
  }
}