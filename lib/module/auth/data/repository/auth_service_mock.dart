import 'package:moreway/module/auth/domain/dependency/i_auth_service.dart';
import 'package:moreway/module/auth/domain/entity/signin_data.dart';
import 'package:moreway/module/auth/domain/entity/signup_data.dart';
import 'package:moreway/module/auth/domain/entity/token.dart';
import 'package:moreway/module/user/domain/entity/user_profile.dart';

class AuthServiceMock implements IAuthService {
  @override
  Future<Token> signIn(SignInData data) async {
    return Token("accessToken");
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<Token> signUp(SignUpData data) async {
    return Token("accessToken");
  }
  
  @override
  Future<String> getUserId() {
    // TODO: implement getUserId
    throw UnimplementedError();
  }

  @override
  Future<UserProfile> getProfileData() {
    // TODO: implement getProfileData
    throw UnimplementedError();
  }
}
