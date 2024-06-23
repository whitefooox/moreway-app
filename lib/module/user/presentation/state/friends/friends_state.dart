part of 'friends_bloc.dart';

class FriendsState {
  final LoadingStatus searchStatus;
  final List<UserRelationship>? searchedUsers;

  final PaginatedPage<UserPreview>? friends;
  final LoadingStatus friendsStatus;

  final PaginatedPage<UserPreview>? friendRequests;
  final LoadingStatus friendRequestsStatus;

  FriendsState({
    this.searchStatus = LoadingStatus.initial,
    this.searchedUsers,
    this.friends,
    this.friendsStatus = LoadingStatus.initial,
    this.friendRequests,
    this.friendRequestsStatus = LoadingStatus.initial
  });

  FriendsState copyWith({
    LoadingStatus? searchStatus,
    List<UserRelationship>? Function()? searchedUsers,
    LoadingStatus? friendsStatus,
    PaginatedPage<UserPreview>? friends,
    PaginatedPage<UserPreview>? friendRequests,
    LoadingStatus? friendRequestsStatus
  }) {
    return FriendsState(
      searchStatus: searchStatus ?? this.searchStatus,
      searchedUsers: searchedUsers != null ? searchedUsers() : this.searchedUsers,
      friendsStatus: friendsStatus ?? this.friendsStatus,
      friends: friends ?? this.friends,
      friendRequests: friendRequests ?? this.friendRequests,
      friendRequestsStatus: friendRequestsStatus ?? this.friendRequestsStatus
    );
  }
}
