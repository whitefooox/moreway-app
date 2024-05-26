part of 'route_builder_bloc.dart';

@immutable
sealed class RouteBuilderEvent {}

final class LoadRouteBuilderEvent extends RouteBuilderEvent {}

final class AddPlaceRouteBuilderEvent extends RouteBuilderEvent {
  final String placeId;

  AddPlaceRouteBuilderEvent({required this.placeId});
}

final class RemovePlaceRouteBuilderEvent extends RouteBuilderEvent {
  final String placeId;

  RemovePlaceRouteBuilderEvent({required this.placeId});
}

final class UpdateAllRouteBuilderEvent extends RouteBuilderEvent {
  final RouteRaw route;

  UpdateAllRouteBuilderEvent({required this.route});
}

final class CreateRouteBuilderEvent extends RouteBuilderEvent {
  final String name;

  CreateRouteBuilderEvent({required this.name});
}
