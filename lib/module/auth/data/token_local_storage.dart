import 'package:moreway/module/auth/domain/dependency/i_token_manager.dart';
import 'package:moreway/module/auth/domain/entity/token.dart';

class TokenLocalStorage implements ITokenManager {

  @override
  void delete() {
    // TODO: implement delete
  }

  @override
  Token? get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  void save(Token token) {
    // TODO: implement save
  }
  
}