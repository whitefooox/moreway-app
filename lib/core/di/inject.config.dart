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
import 'package:shared_preferences/shared_preferences.dart' as _i16;

import '../../module/auth/data/repository/auth_service_api.dart' as _i6;
import '../../module/auth/data/repository/token_secure_storage.dart' as _i14;
import '../../module/auth/domain/dependency/i_auth_service.dart' as _i5;
import '../../module/auth/domain/dependency/i_token_storage.dart' as _i13;
import '../../module/auth/domain/usecase/check_authorization_usecase.dart'
    as _i20;
import '../../module/auth/domain/usecase/signin_usecase.dart' as _i17;
import '../../module/auth/domain/usecase/signout_usecase.dart' as _i18;
import '../../module/auth/domain/usecase/signup_usecase.dart' as _i19;
import '../../module/auth/presentation/bloc/auth_bloc.dart' as _i29;
import '../../module/location/data/geolocator_service.dart' as _i12;
import '../../module/location/data/osm_geoincoder.dart' as _i8;
import '../../module/location/data/permission_service.dart' as _i10;
import '../../module/location/domain/dependency/i_geoincoder_service.dart'
    as _i7;
import '../../module/location/domain/dependency/i_location_permission_service.dart'
    as _i9;
import '../../module/location/domain/dependency/i_location_service.dart'
    as _i11;
import '../../module/location/domain/usecase/get_current_city.dart' as _i21;
import '../../module/location/domain/usecase/get_current_location.dart' as _i22;
import '../../module/location/domain/usecase/send_request_location_permission.dart'
    as _i15;
import '../../module/location/presentation/state/bloc/location_bloc.dart'
    as _i27;
import '../../module/place/data/place_repository_api.dart' as _i26;
import '../../module/place/domain/dependency/i_place_repository.dart' as _i25;
import '../../module/place/domain/usecase/get_places.dart' as _i31;
import '../../module/place/presentation/state/bloc/places_bloc.dart' as _i33;
import '../../module/welcome/data/launch_checker.dart' as _i24;
import '../../module/welcome/domain/dependency/i_launch_checker.dart' as _i23;
import '../../module/welcome/domain/usecase/check_first_launch.dart' as _i30;
import '../../module/welcome/domain/usecase/set_status_first_launch.dart'
    as _i28;
import '../../module/welcome/presentation/bloc/launch_bloc.dart' as _i32;
import 'inject.dart' as _i34;

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
    gh.singleton<_i4.FlutterSecureStorage>(() => registerModule.secureStorage);
    gh.singleton<_i5.IAuthService>(() => _i6.AuthServiceAPI(gh<_i3.Dio>()));
    gh.singleton<_i7.IGeoincoderService>(() => _i8.OSMGeoincoderService());
    gh.singleton<_i9.ILocationPermissionService>(
        () => _i10.GeolocatorPermissionService());
    gh.singleton<_i11.ILocationService>(() => _i12.GeolocatorService());
    gh.singleton<_i13.ITokenStorage>(
        () => _i14.TokenSecureStorage(gh<_i4.FlutterSecureStorage>()));
    gh.singleton<_i15.SendRequestLocationPermissionUseCase>(() =>
        _i15.SendRequestLocationPermissionUseCase(
            gh<_i9.ILocationPermissionService>()));
    await gh.factoryAsync<_i16.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i17.SignInUseCase>(() => _i17.SignInUseCase(
          gh<_i5.IAuthService>(),
          gh<_i13.ITokenStorage>(),
        ));
    gh.singleton<_i18.SignOutUseCase>(() => _i18.SignOutUseCase(
          gh<_i5.IAuthService>(),
          gh<_i13.ITokenStorage>(),
        ));
    gh.singleton<_i19.SignUpUseCase>(() => _i19.SignUpUseCase(
          gh<_i5.IAuthService>(),
          gh<_i13.ITokenStorage>(),
        ));
    gh.singleton<_i20.CheckAuthorizationUseCase>(
        () => _i20.CheckAuthorizationUseCase(gh<_i13.ITokenStorage>()));
    gh.singleton<_i21.GetCurrentCityUseCase>(() => _i21.GetCurrentCityUseCase(
          gh<_i7.IGeoincoderService>(),
          gh<_i9.ILocationPermissionService>(),
          gh<_i11.ILocationService>(),
        ));
    gh.singleton<_i22.GetCurrentPositionUseCase>(
        () => _i22.GetCurrentPositionUseCase(
              gh<_i9.ILocationPermissionService>(),
              gh<_i11.ILocationService>(),
            ));
    gh.singleton<_i23.ILaunchChecker>(
        () => _i24.LaunchChecker(gh<_i16.SharedPreferences>()));
    gh.singleton<_i25.IPlaceRepository>(() => _i26.PlaceRepositoryAPI(
          gh<_i3.Dio>(),
          gh<_i22.GetCurrentPositionUseCase>(),
        ));
    gh.singleton<_i27.LocationBloc>(
        () => _i27.LocationBloc(gh<_i21.GetCurrentCityUseCase>()));
    gh.singleton<_i28.SetStatusFirstLaunchUseCase>(
        () => _i28.SetStatusFirstLaunchUseCase(gh<_i23.ILaunchChecker>()));
    gh.lazySingleton<_i29.AuthBloc>(() => _i29.AuthBloc(
          gh<_i17.SignInUseCase>(),
          gh<_i19.SignUpUseCase>(),
          gh<_i20.CheckAuthorizationUseCase>(),
          gh<_i18.SignOutUseCase>(),
        ));
    gh.singleton<_i30.CheckFirstLaunchUseCase>(
        () => _i30.CheckFirstLaunchUseCase(gh<_i23.ILaunchChecker>()));
    gh.singleton<_i31.GetPlacesUseCase>(
        () => _i31.GetPlacesUseCase(gh<_i25.IPlaceRepository>()));
    gh.singleton<_i32.LaunchBloc>(() => _i32.LaunchBloc(
          gh<_i30.CheckFirstLaunchUseCase>(),
          gh<_i28.SetStatusFirstLaunchUseCase>(),
          gh<_i15.SendRequestLocationPermissionUseCase>(),
        ));
    gh.factory<_i33.PlacesBloc>(
        () => _i33.PlacesBloc(gh<_i31.GetPlacesUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i34.RegisterModule {}
