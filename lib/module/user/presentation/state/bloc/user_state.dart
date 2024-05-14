part of 'user_bloc.dart';

class UserState {
  final UserPreview? user;
  final LoadingStatus loadingStatus;

  UserState({
    this.user,
    this.loadingStatus = LoadingStatus.initial,
  });

  UserState copyWith({
    UserPreview? user,
    LoadingStatus? loadingStatus,
  }) {
    return UserState(
      user: user ?? this.user,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
