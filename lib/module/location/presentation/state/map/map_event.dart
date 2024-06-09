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
