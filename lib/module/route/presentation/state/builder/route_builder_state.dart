part of 'route_builder_bloc.dart';

class RouteBuilderState {
  final RouteRaw? route;
  final LoadingStatus routeStatus;

  final LoadingStatus addPlaceStatus;
  final LoadingStatus removePlaceStatus;
  final LoadingStatus reorderPlacesStatus;

  RouteBuilderState({
    this.route,
    this.routeStatus = LoadingStatus.initial,
    this.addPlaceStatus = LoadingStatus.initial,
    this.removePlaceStatus = LoadingStatus.initial,
    this.reorderPlacesStatus = LoadingStatus.initial,
  });

  RouteBuilderState copyWith({
    RouteRaw? route,
    LoadingStatus? routeStatus,
    LoadingStatus? addPlaceStatus,
    LoadingStatus? removePlaceStatus,
    LoadingStatus? reorderPlacesStatus,
  }) {
    return RouteBuilderState(
      route: route ?? this.route,
      routeStatus: routeStatus ?? this.routeStatus,
      addPlaceStatus: addPlaceStatus ?? this.addPlaceStatus,
      removePlaceStatus: removePlaceStatus ?? this.removePlaceStatus,
      reorderPlacesStatus: reorderPlacesStatus ?? this.reorderPlacesStatus,
    );
  }
}
