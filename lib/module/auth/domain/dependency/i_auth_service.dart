import 'package:moreway/module/auth/domain/entity/auth_data.dart';
import 'package:moreway/module/auth/domain/entity/token.dart';

abstract class IAuthService {
  Future<Token> signIn(AuthData data);
  Future<Token> signUp(AuthData data);
}