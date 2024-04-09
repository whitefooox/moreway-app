part of 'places_bloc.dart';

@immutable
sealed class PlacesEvent {}

class LoadPlacesEvent extends PlacesEvent {}

class SearchPlacesEvent extends PlacesEvent {
  final String? query;

  SearchPlacesEvent(this.query);
}
