part of 'rating_bloc.dart';

@immutable
sealed class RatingEvent {}

class LoadRatingEvent extends RatingEvent {}
