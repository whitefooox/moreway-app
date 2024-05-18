part of 'route_builder_bloc.dart';

class RouteBuilderState {
  final List<IndexedPlace>? places;
  final LoadingStatus placesStatus;

  final LoadingStatus addPlaceStatus;
  final LoadingStatus removePlaceStatus;
  final LoadingStatus reorderPlacesStatus;

  RouteBuilderState({
    this.places,
    this.placesStatus = LoadingStatus.initial,
    this.addPlaceStatus = LoadingStatus.initial,
    this.removePlaceStatus = LoadingStatus.initial,
    this.reorderPlacesStatus = LoadingStatus.initial,
  });
}
