import 'dart:developer';

import 'package:moreway/core/case/future_usecase.dart';
import 'package:moreway/module/auth/domain/dependency/i_auth_service.dart';
import 'package:moreway/module/auth/domain/dependency/i_token_storage.dart';
import 'package:moreway/module/auth/domain/entity/signin_data.dart';

class SignInUseCase extends FutureUseCase<SignInData, void> {

  final IAuthService _authService;
  final ITokenStorage _tokenStorage;

  SignInUseCase(
    this._authService,
    this._tokenStorage
  );

  @override
  Future<void> call(SignInData input) async {
    try {
      final token = await _authService.signIn(input);
      _tokenStorage.save(token);
    } catch (e) {
      log("[sign in use case] $e");
      rethrow;
    }
  }
}