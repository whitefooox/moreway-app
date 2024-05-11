import 'package:moreway/module/user/domain/entity/user_info.dart';

abstract class IUserRepository {
  Future<UserInfo> getUserByToken();
}