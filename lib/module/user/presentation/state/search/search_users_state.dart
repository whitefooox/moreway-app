part of 'search_users_bloc.dart';

class SearchUsersState {
  final LoadingStatus status;
  final List<UserRelationship>? users;
  
  SearchUsersState({
    this.status = LoadingStatus.initial,
    this.users,
  });

  SearchUsersState copyWith({
    LoadingStatus? status,
    List<UserRelationship>? users,
  }) {
    return SearchUsersState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }
}
