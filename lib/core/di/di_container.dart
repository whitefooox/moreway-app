import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:moreway/core/api/api_client.dart';
import 'package:moreway/core/navigation/navigation.dart';
import 'package:moreway/module/auth/data/repository/auth_service_api.dart';
import 'package:moreway/module/auth/data/repository/token_secure_storage.dart';
import 'package:moreway/module/auth/domain/dependency/i_auth_service.dart';
import 'package:moreway/module/auth/domain/dependency/i_token_storage.dart';
import 'package:moreway/module/auth/domain/usecase/check_authorization_usecase.dart';
import 'package:moreway/module/auth/domain/usecase/signin_usecase.dart';
import 'package:moreway/module/auth/domain/usecase/signout_usecase.dart';
import 'package:moreway/module/auth/domain/usecase/signup_usecase.dart';
import 'package:moreway/module/auth/presentation/bloc/auth_bloc.dart';

class DIContainer {
  final GetIt locator = GetIt.instance;

  void _injectAuthModule(){
    locator.registerSingleton(Dio());
    locator.registerSingleton(const FlutterSecureStorage());
    locator.registerSingleton<ITokenStorage>(TokenSecureStorage(locator()));
    setupApiClient(locator(), locator());
    locator.registerSingleton<IAuthService>(AuthServiceAPI(locator()));
    locator.registerLazySingleton(() => SignInUseCase(locator(), locator()));
    locator.registerLazySingleton(() => SignUpUseCase(locator(), locator()));
    locator.registerLazySingleton(() => CheckAuthorizationUseCase(locator()));
    locator.registerLazySingleton(() => SignOutUseCase(locator(), locator()));
    locator.registerSingleton(AuthBloc(locator(), locator(), locator(), locator())..add(AuthCheckAuthorizationEvent()));
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