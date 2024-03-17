import 'package:moreway/module/auth/domain/dependency/i_auth_service.dart';
import 'package:moreway/module/auth/domain/entity/signin_data.dart';
import 'package:moreway/module/auth/domain/entity/signup_data.dart';

import 'package:moreway/module/auth/domain/entity/token.dart';
import 'package:moreway/module/auth/domain/exception/auth_exception.dart';

class MockAuthService implements IAuthService {
  @override
  Future<Token> signIn(SignInData data) async {
    await Future.delayed(const Duration(seconds: 2));
    if(data.email == "error@error.error"){
      throw Exception();
    }
    if(data.email == data.password){
      return Token("data");
    } else {
      throw const AuthException(message: "Неправильная почта или пароль!");
    }
  }

  @override
  Future<Token> signUp(SignUpData data) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  
}