import 'dart:developer';

import 'package:moreway/core/api/api.dart';
import 'package:moreway/core/api/api_client.dart';
import 'package:moreway/module/game/data/mapping/leaders_model.dart';
import 'package:moreway/module/game/domain/dependency/i_score_repository.dart';
import 'package:moreway/module/game/domain/entity/user_score_position.dart';

class ScoreRepositoryAPI implements IScoreRepository {

  final ApiClient _client;

  ScoreRepositoryAPI(this._client);

  @override
  Future<List<UserScorePosition>> getLeaders() async {
    try {
      final response = await _client.dio.get(Api.rating);
      final json = response.data['data'];
      return LeadersModel.fromJson(json).toUserScorePositionList();
    } catch (e, stackTrace) {
      log("[score repository api] $e", stackTrace: stackTrace);
      rethrow;
    }
  }
}