part of 'routes_bloc.dart';

@immutable
sealed class RoutesEvent {}

class LoadRoutesEvent extends RoutesEvent {}

class LoadMoreRoutesEvent extends RoutesEvent {}