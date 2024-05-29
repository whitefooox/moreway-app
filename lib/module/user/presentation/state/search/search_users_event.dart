part of 'search_users_bloc.dart';

@immutable
sealed class SearchUsersEvent {}

class SearchUsersByNameEvent extends SearchUsersEvent {
  final String? query;

  SearchUsersByNameEvent({required this.query});
}
