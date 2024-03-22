import 'package:moreway/module/auth/domain/entity/token.dart';

abstract class ITokenStorage {
  void save(Token token);
  void delete();
  Future<Token?> get();
}