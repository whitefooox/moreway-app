import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/module/game/domain/entity/user_score_position.dart';
import 'package:moreway/module/game/domain/interactor/score_interactor.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {

  final ScoreInteractor _scoreInteractor;

  RatingBloc(this._scoreInteractor) : super(RatingState()) {
    on<LoadRatingEvent>(_load);
  }

  void _load(LoadRatingEvent event, Emitter<RatingState> emit) async {
    emit(state.copyWith(ratingStatus: LoadingStatus.loading));
    try {
      final leaders = await _scoreInteractor.getLeaders();
      emit(state.copyWith(ratingStatus: LoadingStatus.success, leaders: leaders));
    } catch (e) {
      emit(state.copyWith(ratingStatus: LoadingStatus.failure));
    }
  }
}
