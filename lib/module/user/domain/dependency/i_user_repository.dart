import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/user/domain/entity/user_preview.dart';
import 'package:moreway/module/user/domain/entity/user_profile.dart';

abstract class IUserRepository {
  Future<UserProfile> getProfileData();
  Future<String> getUserId();
  Future<PaginatedPage<UserPreview>> getUsersByName({String? name, String? cursor});
}