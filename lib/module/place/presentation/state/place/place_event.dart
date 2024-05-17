part of 'place_bloc.dart';

@immutable
sealed class PlaceEvent {}

class PlaceLoadEvent extends PlaceEvent {
  final String id;

  PlaceLoadEvent({required this.id});
}

class CreateReviewPlaceEvent extends PlaceEvent {
  final ReviewRaw review;

  CreateReviewPlaceEvent({required this.review});
}

class LoadMoreReviewsPlaceEvent extends PlaceEvent {}