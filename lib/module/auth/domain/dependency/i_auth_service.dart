import 'package:moreway/module/auth/domain/entity/signin_data.dart';
import 'package:moreway/module/auth/domain/entity/signup_data.dart';
import 'package:moreway/module/auth/domain/entity/token.dart';

abstract class IAuthService {
  Future<Token> signIn(SignInData data);
  Future<Token> signUp(SignUpData data);
}