part of 'rating_bloc.dart';

class RatingState {
  final LoadingStatus ratingStatus;
  final List<UserScorePosition>? leaders;

  RatingState({
    this.ratingStatus = LoadingStatus.initial,
    this.leaders,
  });

  RatingState copyWith({
    LoadingStatus? ratingStatus,
    List<UserScorePosition>? leaders,
  }) {
    return RatingState(
      ratingStatus: ratingStatus ?? this.ratingStatus,
      leaders: leaders ?? this.leaders,
    );
  }
}
