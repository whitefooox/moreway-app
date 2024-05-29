part of 'search_users_bloc.dart';

class SearchUsersState {
  final LoadingStatus status;
  final List<UserPreview>? users;
  
  SearchUsersState({
    this.status = LoadingStatus.initial,
    this.users,
  });

  SearchUsersState copyWith({
    LoadingStatus? status,
    List<UserPreview>? users,
  }) {
    return SearchUsersState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }
}
