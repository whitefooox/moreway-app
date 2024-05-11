part of 'user_bloc.dart';

class UserState {
  final UserInfo? info;
  final LoadingStatus loadingStatus;

  UserState({
    this.info,
    this.loadingStatus = LoadingStatus.initial,
  });

  UserState copyWith({
    UserInfo? info,
    LoadingStatus? loadingStatus,
  }) {
    return UserState(
      info: info ?? this.info,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
