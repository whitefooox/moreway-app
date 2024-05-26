part of 'route_builder_bloc.dart';

enum RouteBuilderOperationStatus {
  initial,
  loading,
  added,
  errorAdding,
  removed,
  errorRemoving,
  updated,
  errorUpdating,
  loadingUpdating,
  created,
  errorCreating,
  loadingCreating
}

class RouteBuilderState {
  final RouteRaw? route;
  final String? errorMessage;
  final LoadingStatus routeStatus;

  final RouteBuilderOperationStatus operationStatus;

  int get placesCount => route != null ? route!.points.length : 0;

  RouteBuilderState({
    this.route,
    this.errorMessage,
    this.routeStatus = LoadingStatus.initial,
    this.operationStatus = RouteBuilderOperationStatus.initial
  });

  RouteBuilderState copyWith({
    RouteRaw? route,
    LoadingStatus? routeStatus,
    String? errorMessage,
    RouteBuilderOperationStatus? operationStatus
  }) {
    return RouteBuilderState(
      route: route ?? this.route,
      routeStatus: routeStatus ?? this.routeStatus,
      operationStatus: operationStatus ?? this.operationStatus,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  RouteBuilderState createdState(){
    return RouteBuilderState(
      routeStatus: routeStatus,
      route: RouteRaw(points: []),
      operationStatus: RouteBuilderOperationStatus.created
    );
  }
}
