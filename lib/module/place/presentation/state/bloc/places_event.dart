part of 'places_bloc.dart';

@immutable
sealed class PlacesEvent {}

class LoadPlacesEvent extends PlacesEvent {}
