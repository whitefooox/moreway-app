part of 'map_bloc.dart';

class MapState {
  final RouteDetailed? activeRoute;
  final LoadingStatus activeRoutestatus;

  final Position? position;
  final LoadingStatus positionStatus;

  final LoadingStatus replaceStatus;

  final PlaceBase? targetPlace;

  final List<PositionPoint>? route;

  MapState({
    this.activeRoute,
    this.position,
    this.activeRoutestatus = LoadingStatus.initial,
    this.positionStatus = LoadingStatus.initial,
    this.replaceStatus = LoadingStatus.initial,
    this.targetPlace,
    this.route
  });
  

  MapState copyWith({
    RouteDetailed? activeRoute,
    LoadingStatus? activeRoutestatus,
    Position? position,
    LoadingStatus? positionStatus,
    LoadingStatus? replaceStatus,
    PlaceBase? targetPlace,
    List<PositionPoint>? route
  }) {
    return MapState(
      activeRoute: activeRoute ?? this.activeRoute,
      activeRoutestatus: activeRoutestatus ?? this.activeRoutestatus,
      position: position ?? this.position,
      positionStatus: positionStatus ?? this.positionStatus,
      replaceStatus: replaceStatus ?? this.replaceStatus,
      targetPlace: targetPlace ?? this.targetPlace,
      route: route ?? this.route
    );
  }
}

