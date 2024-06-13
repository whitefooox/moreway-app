part of 'map_bloc.dart';

@immutable
sealed class MapEvent {}

class LoadActiveRouteEvent extends MapEvent {}

class SubscribeToPositionsEvent extends MapEvent {}

class SetActiveRouteEvent extends MapEvent {
  final String routeId;

  SetActiveRouteEvent(this.routeId);
}

class ResetMapEvent extends MapEvent {}

class CompletePlaceEvent extends MapEvent {}

class _CreateRouteEvent extends MapEvent {}

class _UpdateRouteProgressEvent extends MapEvent {
  final Position position;

  _UpdateRouteProgressEvent(this.position);
}
