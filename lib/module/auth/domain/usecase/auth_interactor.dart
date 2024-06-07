import 'dart:developer';

import 'package:moreway/module/auth/domain/dependency/i_auth_service.dart';
import 'package:moreway/module/auth/domain/dependency/i_token_storage.dart';
import 'package:moreway/module/auth/domain/entity/signin_data.dart';
import 'package:moreway/module/auth/domain/entity/signup_data.dart';
import 'package:moreway/module/user/domain/dependency/i_user_repository.dart';

class AuthInteractor {
  final IAuthService _authService;
  final ITokenStorage _tokenStorage;
  final IUserRepository _userRepository;

  AuthInteractor(this._authService, this._tokenStorage, this._userRepository);

  Future<void> signIn(SignInData input) async {
    try {
      final token = await _authService.signIn(input);
      _tokenStorage.save(token);
    } catch (e) {
      log("[sign in use case] $e");
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _userRepository.removeUserId();
    _tokenStorage.delete();
  }

  Future<void> signUp(SignUpData input) async {
    try {
      final token = await _authService.signUp(input);
      _tokenStorage.save(token);
    } catch (e) {
      log("[sign up use case] $e");
      rethrow;
    }
  }

  Future<bool> checkAuthorization() async {
    return (await _tokenStorage.get() != null);
  }
}
