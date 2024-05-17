// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'place_bloc.dart';

class PlaceState {
  final String? placeId;
  final PlaceDetailed? place;
  final LoadingStatus placeDetailedStatus;

  final List<Review>? reviews;
  final LoadingStatus reviewsStatus;
  final String? reviewsCursor;
  final bool reviewsHasReachedMax;

  final LoadingStatus createReviewStatus;
  final String? createReviewError;

  PlaceState({
    this.placeId,
    this.placeDetailedStatus = LoadingStatus.initial,
    this.reviewsStatus = LoadingStatus.initial,
    this.place,
    this.reviewsHasReachedMax = false,
    this.reviewsCursor,
    this.reviews,
    this.createReviewStatus = LoadingStatus.initial,
    this.createReviewError
  });

  PlaceState copyWith({
    String? placeId,
    PlaceDetailed? place,
    LoadingStatus? placeDetailedStatus,
    List<Review>? reviews,
    LoadingStatus? reviewsStatus,
    String? reviewsCursor,
    bool? reviewsHasReachedMax,
    LoadingStatus? createReviewStatus,
    String? createReviewError,
  }) {
    return PlaceState(
      placeId: placeId ?? this.placeId,
      place: place ?? this.place,
      placeDetailedStatus: placeDetailedStatus ?? this.placeDetailedStatus,
      reviews: reviews ?? this.reviews,
      reviewsStatus: reviewsStatus ?? this.reviewsStatus,
      reviewsCursor: reviewsCursor ?? this.reviewsCursor,
      reviewsHasReachedMax: reviewsHasReachedMax ?? this.reviewsHasReachedMax,
      createReviewStatus: createReviewStatus ?? this.createReviewStatus,
      createReviewError: createReviewError ?? this.createReviewError,
    );
  }
}
