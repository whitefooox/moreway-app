import 'package:injectable/injectable.dart';
import 'package:moreway/module/auth/domain/dependency/i_auth_service.dart';
import 'package:moreway/module/auth/domain/dependency/i_token_storage.dart';

@Singleton()
class SignOutUseCase {
  final ITokenStorage _tokenStorage;
  final IAuthService _authService;

  SignOutUseCase(this._authService, this._tokenStorage);

  Future<void> execute() async {
    await _authService.signOut();
    _tokenStorage.delete();
  }
}