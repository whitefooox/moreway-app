import 'dart:developer';

import 'package:moreway/module/auth/domain/dependency/i_auth_service.dart';
import 'package:moreway/module/auth/domain/dependency/i_token_storage.dart';
import 'package:moreway/module/auth/domain/entity/signin_data.dart';
import 'package:moreway/module/auth/domain/entity/signup_data.dart';
import 'package:moreway/module/auth/domain/entity/user_profile.dart';

class AuthInteractor {
  final IAuthService _authService;
  final ITokenStorage _tokenStorage;

  AuthInteractor(this._authService, this._tokenStorage);

  Future<UserProfile> _getUserProfile() async {
    try {
      final profile = await _authService.getProfileData();
      return profile;
    } catch (e) {
      log("[sign up use case] $e");
      rethrow;
    }
  }

  Future<UserProfile?> getAuthorizedUserProfile() async {
    if((await _tokenStorage.get()) != null){
      return _getUserProfile();
    } else {
      return null;
    }
  }

  Future<UserProfile> signIn(SignInData input) async {
    try {
      final token = await _authService.signIn(input);
      _tokenStorage.save(token);
      return _getUserProfile();
    } catch (e) {
      log("[sign in use case] $e");
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _tokenStorage.delete();
  }

  Future<UserProfile> signUp(SignUpData input) async {
    try {
      final token = await _authService.signUp(input);
      _tokenStorage.save(token);
      return _getUserProfile();
    } catch (e) {
      log("[sign up use case] $e");
      rethrow;
    }
  }
}
