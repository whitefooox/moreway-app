import 'package:moreway/module/game/domain/entity/user_score_position.dart';

abstract class IScoreRepository {
  Future<List<UserScorePosition>> getLeaders();
}