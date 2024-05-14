import 'package:moreway/module/user/domain/entity/user_preview.dart';

abstract class IUserRepository {
  Future<UserPreview> getUserByToken();
}