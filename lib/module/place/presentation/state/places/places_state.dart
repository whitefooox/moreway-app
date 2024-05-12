// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'places_bloc.dart';

enum PlacesStatus {initial, success, failure}

class PlacesState {
  final PlacesStatus status;
  final bool hasReachedMax;
  final String? errorMessage;
  final List<Place>? places;
  final String? cursor;
  final SelectedPlaceFilters filters;
  final PlaceFilterOptions? filterOptions;

  PlacesState(
      {this.status = PlacesStatus.initial,
      this.errorMessage,
      this.places,
      this.cursor,
      this.hasReachedMax = false,
      this.filters = const SelectedPlaceFilters(),
      this.filterOptions});

  PlacesState resetData() {
    return copyWith(
      status: PlacesStatus.initial,
      hasReachedMax: false,
      places: () => null,
      errorMessage: null,
      cursor: null,
    );
  }

  PlacesState copyWith({
    PlacesStatus? status,
    bool? hasReachedMax,
    String? errorMessage,
    List<Place>? Function()? places,
    String? cursor,
    SelectedPlaceFilters? filters,
    PlaceFilterOptions? filterOptions,
  }) {
    return PlacesState(
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      places: places != null ? places() : this.places,
      cursor: cursor ?? this.cursor,
      filters: filters ?? this.filters,
      filterOptions: filterOptions ?? this.filterOptions,
    );
  }
}
