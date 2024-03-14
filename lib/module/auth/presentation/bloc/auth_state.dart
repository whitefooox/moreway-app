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

  AuthState({
    this.status = AuthStatus.unauthorized,
    this.errorMessage
  });

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}
