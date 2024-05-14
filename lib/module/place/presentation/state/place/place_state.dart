// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'place_bloc.dart';

class PlaceState {
  final String? placeId;
  final LoadingStatus loadingStatus;
  final PlaceDetailed? place;

  final List<Review>? reviews;
  final String? cursor;
  final bool hasReachedMax;

  PlaceState({
    this.placeId,
    this.loadingStatus = LoadingStatus.initial,
    this.place,
    this.hasReachedMax = false,
    this.cursor,
    this.reviews
  });

  PlaceState copyWith({
    String? placeId,
    LoadingStatus? loadingStatus,
    PlaceDetailed? place,
    bool? hasReachedMax,
    List<Review>? reviews,
    String? cursor
  }) {
    return PlaceState(
      placeId: placeId ?? this.placeId,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      place: place ?? this.place,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      reviews: reviews ?? this.reviews,
      cursor: cursor ?? this.cursor
    );
  }
}
