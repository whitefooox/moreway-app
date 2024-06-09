part of 'map_bloc.dart';

class MapState {
  final RouteDetailed? activeRoute;
  final LoadingStatus activeRoutestatus;

  final Position? position;
  final LoadingStatus positionStatus;

  final LoadingStatus replaceStatus;

  //PlaceBase get targetPlace => 

  MapState({
    this.activeRoute,
    this.position,
    this.activeRoutestatus = LoadingStatus.initial,
    this.positionStatus = LoadingStatus.initial,
    this.replaceStatus = LoadingStatus.initial
  });
  

  MapState copyWith({
    RouteDetailed? activeRoute,
    LoadingStatus? activeRoutestatus,
    Position? position,
    LoadingStatus? positionStatus,
    LoadingStatus? replaceStatus
  }) {
    return MapState(
      activeRoute: activeRoute ?? this.activeRoute,
      activeRoutestatus: activeRoutestatus ?? this.activeRoutestatus,
      position: position ?? this.position,
      positionStatus: positionStatus ?? this.positionStatus,
      replaceStatus: replaceStatus ?? this.replaceStatus
    );
  }
}

