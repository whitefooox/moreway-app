import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moreway/module/auth/domain/entity/auth_data.dart';
import 'package:moreway/module/auth/domain/exception/auth_exception.dart';
import 'package:moreway/module/auth/domain/usecase/signin_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final SignInUseCase _signInUseCase;

  AuthBloc(
    this._signInUseCase
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
      await _signInUseCase.call(AuthData(
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
  ){}
}
