import 'dart:developer';

import 'package:moreway/core/case/future_usecase.dart';
import 'package:moreway/module/auth/domain/dependency/i_auth_service.dart';
import 'package:moreway/module/auth/domain/dependency/i_token_manager.dart';
import 'package:moreway/module/auth/domain/entity/auth_data.dart';

class SignInUseCase extends FutureUseCase<AuthData, void> {

  final IAuthService _authService;
  final ITokenManager _tokenManager;

  SignInUseCase(
    this._authService,
    this._tokenManager
  );

  @override
  Future<void> call(AuthData input) async {
    try {
      final token = await _authService.signIn(input);
      _tokenManager.save(token);
    } catch (e) {
      log("[sign in use case] $e");
      rethrow;
    }
  }
}