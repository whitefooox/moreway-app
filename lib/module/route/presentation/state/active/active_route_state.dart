part of 'active_route_bloc.dart';

class ActiveRouteState {
  final RouteDetailed? activeRoute;
  final LoadingStatus activeRoutestatus;

  ActiveRouteState({
    this.activeRoute,
    this.activeRoutestatus = LoadingStatus.initial,
  });
  

  ActiveRouteState copyWith({
    RouteDetailed? activeRoute,
    LoadingStatus? activeRoutestatus,
  }) {
    return ActiveRouteState(
      activeRoute: activeRoute ?? this.activeRoute,
      activeRoutestatus: activeRoutestatus ?? this.activeRoutestatus,
    );
  }
}

