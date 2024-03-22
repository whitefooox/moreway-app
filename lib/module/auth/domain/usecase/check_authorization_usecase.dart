import 'package:moreway/module/auth/domain/dependency/i_token_storage.dart';

class CheckAuthorizationUseCase {

  final ITokenStorage _tokenSecureStorage;

  CheckAuthorizationUseCase(this._tokenSecureStorage);

  Future<bool> execute() async {
    return (await _tokenSecureStorage.get()) != null;
  }
}