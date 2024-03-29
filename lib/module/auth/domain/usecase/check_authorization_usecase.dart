import 'package:injectable/injectable.dart';
import 'package:moreway/module/auth/domain/dependency/i_token_storage.dart';

@Singleton()
class CheckAuthorizationUseCase {

  final ITokenStorage _tokenSecureStorage;

  CheckAuthorizationUseCase(this._tokenSecureStorage);

  Future<bool> execute() async {
    return (await _tokenSecureStorage.get()) != null;
  }
}