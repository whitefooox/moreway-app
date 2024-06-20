import 'dart:developer';

import 'package:moreway/core/api/api.dart';
import 'package:moreway/core/api/api_client.dart';
import 'package:moreway/core/api/paginated_page.dart';
import 'package:moreway/module/user/data/mapping/friends_page_model.dart';
import 'package:moreway/module/user/data/mapping/user_profile_model.dart';
import 'package:moreway/module/user/data/mapping/users_page_model.dart';
import 'package:moreway/module/user/domain/entity/user_preview.dart';
import 'package:moreway/module/user/domain/entity/user_profile.dart';
import 'package:moreway/module/user/domain/dependency/i_user_repository.dart';
import 'package:moreway/module/user/domain/entity/user_relationship.dart';

class UserRepositoryAPI implements IUserRepository {
  final ApiClient _client;
  final int _friendsLimit = 8;
  String? _userId;

  UserRepositoryAPI(this._client);

  @override
  Future<UserProfile> getProfileData() async {
    try {
      final response = await _client.dio.get(Api.authMe);
      final json = response.data['data'];
      final model = UserProfileModel.fromJson(json);
      final profile = model.toUserProfile();
      _userId = profile.id;
      return profile;
    } catch (e) {
      log("[auth  api] $e");
      rethrow;
    }
  }

  @override
  Future<String> getUserId() async {
    if (_userId != null) {
      return _userId!;
    } else {
      try {
        final response = await _client.dio.get(Api.authMe);
        final json = response.data['data'];
        final model = UserProfileModel.fromJson(json);
        final profile = model.toUserProfile();
        _userId = profile.id;
        return _userId!;
      } catch (e) {
        log("[auth  api] $e");
        rethrow;
      }
    }
  }

  @override
  Future<PaginatedPage<UserRelationship>> getUsersByName({String? name, String? cursor}) async {
    try {
      final response = await _client.dio
          .get(Api.users, queryParameters: {"name": name, "cursor": cursor});
      final json = response.data;
      return UsersPageModel.fromJson(json).toUsersRelationship();
    } catch (e) {
      log("[auth  api] $e");
      rethrow;
    }
  }
  
  @override
  void removeUserId() {
    _userId = null;
  }

  @override
  Future<PaginatedPage<UserPreview>> getFriends({String? cursor, required String userId}) async {
    try {
      final response = await _client.dio
          .get(Api.getFriends(userId), queryParameters: {"cursor": cursor, "limit": _friendsLimit});
      final json = response.data;
      return FriendsPageModel.fromJson(json).toUsersPreview();
    } catch (e) {
      log("[auth  api] $e");
      rethrow;
    }
  }
}
