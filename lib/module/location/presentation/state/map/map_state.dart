part of 'map_bloc.dart';

class MapState {
  final RouteDetailed? activeRoute;
  final LoadingStatus activeRoutestatus;

  final Position? position;
  final LoadingStatus positionStatus;

  final LoadingStatus replaceStatus;

  final PlaceBase? targetPlace;

  final RouteInfo? routeInfo;

  MapState({
    this.activeRoute,
    this.position,
    this.activeRoutestatus = LoadingStatus.initial,
    this.positionStatus = LoadingStatus.initial,
    this.replaceStatus = LoadingStatus.initial,
    this.targetPlace,
    this.routeInfo
  });
  

  MapState copyWith({
    RouteDetailed? activeRoute,
    LoadingStatus? activeRoutestatus,
    Position? position,
    LoadingStatus? positionStatus,
    LoadingStatus? replaceStatus,
    PlaceBase? targetPlace,
    RouteInfo? routeInfo
  }) {
    return MapState(
      activeRoute: activeRoute ?? this.activeRoute,
      activeRoutestatus: activeRoutestatus ?? this.activeRoutestatus,
      position: position ?? this.position,
      positionStatus: positionStatus ?? this.positionStatus,
      replaceStatus: replaceStatus ?? this.replaceStatus,
      targetPlace: targetPlace ?? this.targetPlace,
      routeInfo: routeInfo ?? this.routeInfo
    );
  }
}

