// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

enum AuthStatus {
  authorized,
  unauthorized,
  failure,
  loading
}

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final UserProfile? user;

  AuthState({
    this.status = AuthStatus.unauthorized,
    this.errorMessage,
    this.user
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    UserProfile? user
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user
    );
  }

  AuthState logoutState(){
    return AuthState();
  }
}
