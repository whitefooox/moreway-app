import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/module/auth/domain/entity/signin_data.dart';
import 'package:moreway/module/auth/domain/entity/signup_data.dart';
import 'package:moreway/module/auth/domain/exception/auth_exception.dart';
import 'package:moreway/module/auth/domain/usecase/signin_usecase.dart';
import 'package:moreway/module/auth/domain/usecase/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;

  AuthBloc(
    this._signInUseCase,
    this._signUpUseCase
  ) : super(AuthState()) {
    on<AuthCheckAuthorizationEvent>(_checkAuthorization);
    on<AuthSignInEvent>(_signIn);
    on<AuthSignUpEvent>(_signUp);
  }

  void _checkAuthorization(
    AuthCheckAuthorizationEvent event, 
    Emitter<AuthState> emit
  ){}

  void _signIn(
    AuthSignInEvent event, 
    Emitter<AuthState> emit
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _signInUseCase.call(SignInData(
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

  void _signUp(
    AuthSignUpEvent event, 
    Emitter<AuthState> emit
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _signUpUseCase.call(SignUpData(
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
