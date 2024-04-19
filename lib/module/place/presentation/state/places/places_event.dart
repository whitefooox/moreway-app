part of 'places_bloc.dart';

@immutable
sealed class PlacesEvent {}

class LoadPlacesAndFiltersEvent extends PlacesEvent {}

class LoadPlacesEvent extends PlacesEvent {}

class SearchPlacesEvent extends PlacesEvent {
  final String? query;

  SearchPlacesEvent(this.query);
}

class UpdateFiltersEvent extends PlacesEvent {
  final SelectedPlaceFilters filters;

  UpdateFiltersEvent({required this.filters});
}
