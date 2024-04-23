// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'place_bloc.dart';

class PlaceState {
  final String? placeId;
  final LoadingStatus loadingStatus;
  final PlaceDetailed? place;

  PlaceState({
    this.placeId,
    this.loadingStatus = LoadingStatus.initial,
    this.place,
  });

  PlaceState copyWith({
    String? placeId,
    LoadingStatus? loadingStatus,
    PlaceDetailed? place,
  }) {
    return PlaceState(
      placeId: placeId ?? this.placeId,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      place: place ?? this.place,
    );
  }
}
