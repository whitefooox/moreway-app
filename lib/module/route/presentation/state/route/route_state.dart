part of 'route_bloc.dart';

class RouteState {
  final String? routeId;
  final RouteDetailed? route;
  final LoadingStatus routeDetailedStatus;

  final List<PositionPoint>? routeCoordinates;
  final LoadingStatus routeCoordinatesStatus;

  final LoadingStatus activeOperationstatus;
  
  RouteState({
    this.routeId,
    this.route,
    this.routeDetailedStatus = LoadingStatus.initial,
    this.routeCoordinates,
    this.routeCoordinatesStatus = LoadingStatus.initial,
    this.activeOperationstatus = LoadingStatus.initial
  });

  RouteState copyWith({
    String? routeId,
    RouteDetailed? route,
    LoadingStatus? routeDetailedStatus,
    List<PositionPoint>? routeCoordinates,
    LoadingStatus? routeCoordinatesStatus,
    LoadingStatus? activeOperationstatus
  }) {
    return RouteState(
      routeId: routeId ?? this.routeId,
      route: route ?? this.route,
      routeDetailedStatus: routeDetailedStatus ?? this.routeDetailedStatus,
      routeCoordinates: routeCoordinates ?? this.routeCoordinates,
      routeCoordinatesStatus: routeCoordinatesStatus ?? this.routeCoordinatesStatus,
      activeOperationstatus: activeOperationstatus ?? this.activeOperationstatus
    );
  }
}
