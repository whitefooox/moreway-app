import 'dart:developer';

import 'package:moreway/core/api/api.dart';
import 'package:moreway/core/api/api_client.dart';
import 'package:moreway/module/auth/domain/entity/user_profile.dart';
import 'package:moreway/module/user/data/mapping/user_me_model.dart';
import 'package:moreway/module/user/domain/dependency/i_user_repository.dart';

class UserRepositoryAPI implements IUserRepository {
  final ApiClient _client;
  String? _userId;

  UserRepositoryAPI(this._client);

  @override
  Future<UserProfile> getProfileData() async {
    try {
      final response = await _client.dio.get(Api.authMe);
      final json = response.data['data'];
      final model = UserMeModel.fromJson(json);
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
        final model = UserMeModel.fromJson(json);
        final profile = model.toUserProfile();
        _userId = profile.id;
        return _userId!;
      } catch (e) {
        log("[auth  api] $e");
        rethrow;
      }
    }
  }
}
