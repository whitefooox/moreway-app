import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/module/auth/domain/entity/signin_data.dart';
import 'package:moreway/module/auth/domain/entity/signup_data.dart';
import 'package:moreway/module/auth/domain/entity/user_profile.dart';
import 'package:moreway/module/auth/domain/exception/auth_exception.dart';
import 'package:moreway/module/auth/domain/usecase/auth_interactor.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthInteractor _authInteractor;

  AuthBloc(this._authInteractor) : super(AuthState()) {
    on<AuthCheckAuthorizationEvent>(_checkAuthorization);
    on<AuthSignInEvent>(_signIn);
    on<AuthSignUpEvent>(_signUp);
    on<AuthSignOutEvent>(_signOut);
  }

  void _signOut(AuthSignOutEvent event, Emitter<AuthState> emit) async {
    try {
      await _authInteractor.signOut();
      emit(state.logoutState());
    } catch (e) {
      log(e.toString());
    }
  }

  void _checkAuthorization(
      AuthCheckAuthorizationEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final user = await _authInteractor.getAuthorizedUserProfile();
    emit(state.copyWith(
        status:
            user != null ? AuthStatus.authorized : AuthStatus.unauthorized, user: user));
  }

  void _signIn(AuthSignInEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final user = await _authInteractor
          .signIn(SignInData(email: event.email, password: event.password));
      emit(state.copyWith(status: AuthStatus.authorized, user: user));
    } on AuthException catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, errorMessage: e.message));
    }
  }

  void _signUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final user = await _authInteractor.signUp(SignUpData(
          name: event.name, email: event.email, password: event.password));
      emit(state.copyWith(status: AuthStatus.authorized, user: user));
    } on AuthException catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.failure, errorMessage: "Что-то сломалось!"));
    }
  }
}
