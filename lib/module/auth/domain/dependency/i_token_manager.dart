import 'package:moreway/module/auth/domain/entity/token.dart';

abstract class ITokenManager {
  void save(Token token);
  void delete();
  Token? get();
}