// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'places_bloc.dart';

class PlacesState {
  final LoadingStatus loadingStatus;
  final bool isAllLoaded;
  final String? errorMessage;
  final List<Place>? places;
  final String? cursor;
  final SelectedPlaceFilters filters;
  final PlaceFilterOptions? filterOptions;

  PlacesState(
      {this.loadingStatus = LoadingStatus.loading,
      this.errorMessage,
      this.places,
      this.cursor,
      this.isAllLoaded = false,
      this.filters = const SelectedPlaceFilters(),
      this.filterOptions});

  PlacesState resetData() {
    return copyWith(
      loadingStatus: LoadingStatus.loading,
      isAllLoaded: false,
      places: null,
      errorMessage: null,
      cursor: null,
    );
  }

  PlacesState copyWith({
    LoadingStatus? loadingStatus,
    bool? isAllLoaded,
    String? errorMessage,
    List<Place>? places,
    String? cursor,
    SelectedPlaceFilters? filters,
    PlaceFilterOptions? filterOptions,
  }) {
    return PlacesState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      isAllLoaded: isAllLoaded ?? this.isAllLoaded,
      errorMessage: errorMessage ?? this.errorMessage,
      places: places ?? this.places,
      cursor: cursor ?? this.cursor,
      filters: filters ?? this.filters,
      filterOptions: filterOptions ?? this.filterOptions,
    );
  }
}
