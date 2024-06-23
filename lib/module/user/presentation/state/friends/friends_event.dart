part of 'friends_bloc.dart';

@immutable
sealed class FriendsEvent {}

class SearchUsersByNameEvent extends FriendsEvent {
  final String? query;

  SearchUsersByNameEvent({required this.query});
}

class ResetSearchEvent extends FriendsEvent {}

class LoadFriendsEvent extends FriendsEvent {}

class LoadFriendRequestsEvent extends FriendsEvent {}
