part of 'created_routes_bloc.dart';

@immutable
sealed class CreatedRoutesEvent {}

class LoadCreatedRoutesEvent extends CreatedRoutesEvent {}

class LoadMoreCreatedRoutesEvent extends CreatedRoutesEvent {}
