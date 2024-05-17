import 'package:moreway/module/auth/domain/entity/user_profile.dart';

abstract class IUserRepository {
  Future<UserProfile> getProfileData();
  Future<String> getUserId();
}