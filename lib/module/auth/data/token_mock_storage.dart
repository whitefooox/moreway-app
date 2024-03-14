import 'package:moreway/module/auth/domain/dependency/i_token_manager.dart';
import 'package:moreway/module/auth/domain/entity/token.dart';

class TokenMockStorage implements ITokenManager {

  Token? token;

  @override
  void delete() {
    token = null;
  }

  @override
  Token? get() {
    return token;
  }

  @override
  void save(Token token) {
    this.token = token;
  }
}