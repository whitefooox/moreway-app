part of 'places_bloc.dart';

class PlacesState {
  final LoadingStatus loadingStatus;
  final String? errorMessage;
  final List<Place> places;

  PlacesState({
    this.loadingStatus = LoadingStatus.loading,
    this.errorMessage,
    this.places = const [],
  });


  PlacesState copyWith({
    LoadingStatus? loadingStatus,
    String? errorMessage,
    List<Place>? places,
  }) {
    return PlacesState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      places: places ?? this.places,
    );
  }
}
