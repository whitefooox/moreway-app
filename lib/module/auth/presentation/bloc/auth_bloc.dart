import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:moreway/module/auth/domain/entity/signin_data.dart';
import 'package:moreway/module/auth/domain/entity/signup_data.dart';
import 'package:moreway/module/auth/domain/exception/auth_exception.dart';
import 'package:moreway/module/auth/domain/usecase/check_authorization_usecase.dart';
import 'package:moreway/module/auth/domain/usecase/signin_usecase.dart';
import 'package:moreway/module/auth/domain/usecase/signout_usecase.dart';
import 'package:moreway/module/auth/domain/usecase/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@LazySingleton()
class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final CheckAuthorizationUseCase _checkAuthorizationUseCase;
  final SignOutUseCase _signOutUseCase;

  AuthBloc(
    this._signInUseCase,
    this._signUpUseCase,
    this._checkAuthorizationUseCase,
    this._signOutUseCase
  ) : super(AuthState()) {
    on<AuthCheckAuthorizationEvent>(_checkAuthorization);
    on<AuthSignInEvent>(_signIn);
    on<AuthSignUpEvent>(_signUp);
    on<AuthSignOutEvent>(_signOut);
    super.add(AuthCheckAuthorizationEvent());
  }

  void _signOut(
    AuthSignOutEvent event, 
    Emitter<AuthState> emit
  ) async {
    try {
      await _signOutUseCase.execute();
      emit(state.copyWith(status: AuthStatus.unauthorized));
    } catch (e) {
      log(e.toString());
    }
  }

  void _checkAuthorization(
    AuthCheckAuthorizationEvent event, 
    Emitter<AuthState> emit
  ) async {
    final isAuthorized = await _checkAuthorizationUseCase.execute();
    emit(state.copyWith(status: isAuthorized ? AuthStatus.authorized : AuthStatus.unauthorized));
  }

  void _signIn(
    AuthSignInEvent event, 
    Emitter<AuthState> emit
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _signInUseCase.execute(SignInData(
        email: event.email, 
        password: event.password
      ));
      emit(state.copyWith(status: AuthStatus.authorized));
    } on AuthException catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, errorMessage: e.message));
    }
  }

  void _signUp(
    AuthSignUpEvent event, 
    Emitter<AuthState> emit
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _signUpUseCase.execute(SignUpData(
        name: event.name,
        email: event.email, 
        password: event.password
      ));
      emit(state.copyWith(status: AuthStatus.authorized));
    } on AuthException catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, errorMessage: "Что-то сломалось!"));
    }
  }
}
