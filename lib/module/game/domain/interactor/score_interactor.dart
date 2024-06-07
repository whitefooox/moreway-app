import 'package:moreway/module/game/domain/dependency/i_score_repository.dart';
import 'package:moreway/module/game/domain/entity/user_score_position.dart';

class ScoreInteractor {

  final IScoreRepository _scoreRepository;

  ScoreInteractor(this._scoreRepository);

  Future<List<UserScorePosition>> getLeaders(){
    return _scoreRepository.getLeaders();
  }
}