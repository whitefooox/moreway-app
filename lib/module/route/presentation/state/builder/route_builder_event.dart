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

final class ReorderPlacesRouteBuilderEvent extends RouteBuilderEvent {
  final int oldIndex;
  final int newIndex;

  ReorderPlacesRouteBuilderEvent(
      {required this.oldIndex, required this.newIndex});
}

final class UpdateAllRouteBuilderEvent extends RouteBuilderEvent {
  final RouteRaw route;

  UpdateAllRouteBuilderEvent({required this.route});
}

final class CreateRouteBuilderEvent extends RouteBuilderEvent {}
