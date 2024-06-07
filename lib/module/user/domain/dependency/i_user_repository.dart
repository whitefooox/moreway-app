import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/user/domain/entity/user_profile.dart';
import 'package:moreway/module/user/domain/entity/user_relationship.dart';

abstract class IUserRepository {
  Future<UserProfile> getProfileData();
  Future<String> getUserId();
  void removeUserId();
  Future<PaginatedPage<UserRelationship>> getUsersByName({String? name, String? cursor});
}