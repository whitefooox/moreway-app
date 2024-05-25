part of 'route_builder_bloc.dart';

enum RouteBuilderOperationStatus {
  initial,
  loading,
  added,
  errorAdding,
  removed,
  errorRemoving
}

class RouteBuilderState {
  final RouteRaw? route;
  final LoadingStatus routeStatus;

  final RouteBuilderOperationStatus operationStatus;

  int get placesCount => route != null ? route!.points.length : 0;

  RouteBuilderState({
    this.route,
    this.routeStatus = LoadingStatus.initial,
    this.operationStatus = RouteBuilderOperationStatus.initial
  });

  RouteBuilderState copyWith({
    RouteRaw? route,
    LoadingStatus? routeStatus,
    RouteBuilderOperationStatus? operationStatus
  }) {
    return RouteBuilderState(
      route: route ?? this.route,
      routeStatus: routeStatus ?? this.routeStatus,
      operationStatus: operationStatus ?? this.operationStatus
    );
  }
}
