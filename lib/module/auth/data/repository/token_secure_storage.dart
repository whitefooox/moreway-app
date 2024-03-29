import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:moreway/module/auth/domain/dependency/i_token_storage.dart';
import 'package:moreway/module/auth/domain/entity/token.dart';

@Singleton(as: ITokenStorage)
class TokenSecureStorage implements ITokenStorage {

  final FlutterSecureStorage _secureStorage;
  final key = "token";

  TokenSecureStorage(this._secureStorage);

  @override
  void delete() {
    _secureStorage.delete(key: key);
  }

  @override
  Future<Token?> get() async {
    final tokenString = await _secureStorage.read(key: key);
    return tokenString != null ? Token(tokenString) : null;
  }

  @override
  void save(Token token) {
    _secureStorage.write(key: key, value: token.accessToken);
  }
}