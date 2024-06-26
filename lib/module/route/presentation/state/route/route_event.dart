part of 'route_bloc.dart';

@immutable
sealed class RouteEvent {}

class RouteLoadEvent extends RouteEvent {
  final String id;

  RouteLoadEvent({required this.id});
}

class LikeRouteEvent extends RouteEvent {}

class UnlikeRouteEvent extends RouteEvent {}

class ActiveSetRouteEvent extends RouteEvent {}