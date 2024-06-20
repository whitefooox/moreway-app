part of 'favorite_routes_bloc.dart';

@immutable
sealed class FavoriteRoutesEvent {}

class LoadFavoriteRoutesEvent extends FavoriteRoutesEvent {}

class LoadMoreFavoriteRoutesEvent extends FavoriteRoutesEvent {}

class RemoveFavoriteRouteEvent extends FavoriteRoutesEvent {
  final String id;

  RemoveFavoriteRouteEvent(this.id);
}
