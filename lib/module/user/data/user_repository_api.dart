import 'dart:developer';

import 'package:moreway/core/api/api.dart';
import 'package:moreway/core/api/api_client.dart';
import 'package:moreway/module/user/data/mapping/user_me_model.dart';
import 'package:moreway/module/user/domain/dependency/i_user_repository.dart';
import 'package:moreway/module/user/domain/entity/user_info.dart';

class UserRepositoryAPI implements IUserRepository {

  final ApiClient _client;

  UserRepositoryAPI(this._client);

  @override
  Future<UserInfo> getUserByToken() async {
    try {
      final response = await _client.dio.get(Api.authMe);
      final json = response.data['data'];
      final model = UserMeModel.fromJson(json);
      return model.toUserInfo();
    } catch (e) {
      log("[user repository api] $e");
      rethrow;
    }
  }
}