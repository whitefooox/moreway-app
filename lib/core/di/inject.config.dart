// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../module/auth/data/repository/auth_service_api.dart' as _i6;
import '../../module/auth/data/repository/token_secure_storage.dart' as _i8;
import '../../module/auth/domain/dependency/i_auth_service.dart' as _i5;
import '../../module/auth/domain/dependency/i_token_storage.dart' as _i7;
import '../../module/auth/domain/usecase/check_authorization_usecase.dart'
    as _i12;
import '../../module/auth/domain/usecase/signin_usecase.dart' as _i9;
import '../../module/auth/domain/usecase/signout_usecase.dart' as _i10;
import '../../module/auth/domain/usecase/signup_usecase.dart' as _i11;
import '../../module/auth/presentation/bloc/auth_bloc.dart' as _i13;
import 'inject.dart' as _i14;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i3.Dio>(() => registerModule.dio);
    await gh.factoryAsync<_i4.FlutterSecureStorage>(
      () => registerModule.secureStorage,
      preResolve: true,
    );
    gh.singleton<_i5.IAuthService>(() => _i6.AuthServiceAPI(gh<_i3.Dio>()));
    gh.singleton<_i7.ITokenStorage>(
        () => _i8.TokenSecureStorage(gh<_i4.FlutterSecureStorage>()));
    gh.singleton<_i9.SignInUseCase>(() => _i9.SignInUseCase(
          gh<_i5.IAuthService>(),
          gh<_i7.ITokenStorage>(),
        ));
    gh.singleton<_i10.SignOutUseCase>(() => _i10.SignOutUseCase(
          gh<_i5.IAuthService>(),
          gh<_i7.ITokenStorage>(),
        ));
    gh.singleton<_i11.SignUpUseCase>(() => _i11.SignUpUseCase(
          gh<_i5.IAuthService>(),
          gh<_i7.ITokenStorage>(),
        ));
    gh.singleton<_i12.CheckAuthorizationUseCase>(
        () => _i12.CheckAuthorizationUseCase(gh<_i7.ITokenStorage>()));
    gh.singleton<_i13.AuthBloc>(() => _i13.AuthBloc(
          gh<_i9.SignInUseCase>(),
          gh<_i11.SignUpUseCase>(),
          gh<_i12.CheckAuthorizationUseCase>(),
          gh<_i10.SignOutUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i14.RegisterModule {}
