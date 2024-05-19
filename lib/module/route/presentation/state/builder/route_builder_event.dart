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
  final String firstPlaceId;
  final String secondPlaceId;

  ReorderPlacesRouteBuilderEvent(
      {required this.firstPlaceId, required this.secondPlaceId});
}
