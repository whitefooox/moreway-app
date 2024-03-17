import 'package:get_it/get_it.dart';
import 'package:moreway/core/navigation/navigation.dart';
import 'package:moreway/module/auth/data/mock_auth_service.dart';
import 'package:moreway/module/auth/data/token_mock_storage.dart';
import 'package:moreway/module/auth/domain/dependency/i_auth_service.dart';
import 'package:moreway/module/auth/domain/dependency/i_token_manager.dart';
import 'package:moreway/module/auth/domain/usecase/signin_usecase.dart';
import 'package:moreway/module/auth/domain/usecase/signup_usecase.dart';
import 'package:moreway/module/auth/presentation/bloc/auth_bloc.dart';

class DIContainer {
  final GetIt locator = GetIt.instance;

  void _injectAuthModule(){
    locator.registerSingleton<ITokenManager>(TokenMockStorage());
    locator.registerSingleton<IAuthService>(MockAuthService());
    locator.registerLazySingleton(() => SignInUseCase(locator(), locator()));
    locator.registerLazySingleton(() => SignUpUseCase(locator(), locator()));
    locator.registerSingleton(AuthBloc(locator(), locator()));
  }

  void _injectRouter(){
    final authBloc = locator.get<AuthBloc>();
    final router = locator.registerSingleton<AppRouter>(AppRouter(authBloc));
  }

  void buildDependencies(){
    _injectAuthModule();
    _injectRouter();
  }
}