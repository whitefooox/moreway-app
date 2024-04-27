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
import 'package:shared_preferences/shared_preferences.dart' as _i22;

import '../../module/auth/data/repository/auth_service_api.dart' as _i7;
import '../../module/auth/data/repository/auth_service_mock.dart' as _i6;
import '../../module/auth/data/repository/token_secure_storage.dart' as _i20;
import '../../module/auth/domain/dependency/i_auth_service.dart' as _i5;
import '../../module/auth/domain/dependency/i_token_storage.dart' as _i19;
import '../../module/auth/domain/usecase/check_authorization_usecase.dart'
    as _i26;
import '../../module/auth/domain/usecase/signin_usecase.dart' as _i23;
import '../../module/auth/domain/usecase/signout_usecase.dart' as _i24;
import '../../module/auth/domain/usecase/signup_usecase.dart' as _i25;
import '../../module/auth/presentation/bloc/auth_bloc.dart' as _i41;
import '../../module/location/data/geolocator_service.dart' as _i16;
import '../../module/location/data/osm_geoincoder.dart' as _i12;
import '../../module/location/data/permission_service.dart' as _i14;
import '../../module/location/domain/dependency/i_geoincoder_service.dart'
    as _i11;
import '../../module/location/domain/dependency/i_location_permission_service.dart'
    as _i13;
import '../../module/location/domain/dependency/i_location_service.dart'
    as _i15;
import '../../module/location/domain/usecase/get_current_city.dart' as _i27;
import '../../module/location/domain/usecase/get_current_location.dart' as _i28;
import '../../module/location/domain/usecase/get_location_stream.dart' as _i30;
import '../../module/location/domain/usecase/send_request_location_permission.dart'
    as _i21;
import '../../module/location/presentation/state/location/location_bloc.dart'
    as _i36;
import '../../module/location/presentation/state/location_v2/location_v2_bloc.dart'
    as _i37;
import '../../module/place/data/filter_repository_api.dart' as _i9;
import '../../module/place/data/mock/filter_repository_mock.dart' as _i10;
import '../../module/place/data/mock/place_repository_mock.dart' as _i18;
import '../../module/place/data/place_repository_api.dart' as _i35;
import '../../module/place/domain/dependency/i_filter_repository.dart' as _i8;
import '../../module/place/domain/dependency/i_place_repository.dart' as _i17;
import '../../module/place/domain/usecase/get_filters.dart' as _i29;
import '../../module/place/domain/usecase/get_place.dart' as _i31;
import '../../module/place/domain/usecase/get_places.dart' as _i32;
import '../../module/place/presentation/state/place/place_bloc.dart' as _i38;
import '../../module/place/presentation/state/places/places_bloc.dart' as _i39;
import '../../module/welcome/data/launch_checker.dart' as _i34;
import '../../module/welcome/domain/dependency/i_launch_checker.dart' as _i33;
import '../../module/welcome/domain/usecase/check_first_launch.dart' as _i42;
import '../../module/welcome/domain/usecase/set_status_first_launch.dart'
    as _i40;
import '../../module/welcome/presentation/bloc/launch_bloc.dart' as _i43;
import 'inject.dart' as _i44;

const String _dev = 'dev';
const String _prod = 'prod';

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
    gh.singleton<_i5.IAuthService>(
      () => _i6.AuthServiceMock(),
      registerFor: {_dev},
    );
    gh.singleton<_i5.IAuthService>(
      () => _i7.AuthServiceAPI(gh<_i3.Dio>()),
      registerFor: {_prod},
    );
    gh.singleton<_i8.IFilterRepository>(
      () => _i9.FilterRepositoryAPI(gh<_i3.Dio>()),
      registerFor: {_prod},
    );
    gh.singleton<_i8.IFilterRepository>(
      () => _i10.FilterRepositoryMock(),
      registerFor: {_dev},
    );
    gh.singleton<_i11.IGeoincoderService>(() => _i12.OSMGeoincoderService());
    gh.singleton<_i13.ILocationPermissionService>(
        () => _i14.GeolocatorPermissionService());
    gh.singleton<_i15.ILocationService>(() => _i16.GeolocatorService());
    gh.singleton<_i17.IPlaceRepository>(
      () => _i18.PlaceRepositoryMock(),
      registerFor: {_dev},
    );
    gh.singleton<_i19.ITokenStorage>(
        () => _i20.TokenSecureStorage(gh<_i4.FlutterSecureStorage>()));
    gh.singleton<_i21.SendRequestLocationPermissionUseCase>(() =>
        _i21.SendRequestLocationPermissionUseCase(
            gh<_i13.ILocationPermissionService>()));
    await gh.factoryAsync<_i22.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i23.SignInUseCase>(() => _i23.SignInUseCase(
          gh<_i5.IAuthService>(),
          gh<_i19.ITokenStorage>(),
        ));
    gh.singleton<_i24.SignOutUseCase>(() => _i24.SignOutUseCase(
          gh<_i5.IAuthService>(),
          gh<_i19.ITokenStorage>(),
        ));
    gh.singleton<_i25.SignUpUseCase>(() => _i25.SignUpUseCase(
          gh<_i5.IAuthService>(),
          gh<_i19.ITokenStorage>(),
        ));
    gh.singleton<_i26.CheckAuthorizationUseCase>(
        () => _i26.CheckAuthorizationUseCase(gh<_i19.ITokenStorage>()));
    gh.singleton<_i27.GetCurrentCityUseCase>(() => _i27.GetCurrentCityUseCase(
          gh<_i11.IGeoincoderService>(),
          gh<_i13.ILocationPermissionService>(),
          gh<_i15.ILocationService>(),
        ));
    gh.singleton<_i28.GetCurrentPositionUseCase>(
        () => _i28.GetCurrentPositionUseCase(
              gh<_i13.ILocationPermissionService>(),
              gh<_i15.ILocationService>(),
            ));
    gh.singleton<_i29.GetFiltersUsecase>(
        () => _i29.GetFiltersUsecase(gh<_i8.IFilterRepository>()));
    gh.singleton<_i30.GetLocationStreamUsecase>(
        () => _i30.GetLocationStreamUsecase(
              gh<_i15.ILocationService>(),
              gh<_i13.ILocationPermissionService>(),
            ));
    gh.singleton<_i17.IPlaceRepository>(
      () => _i35.PlaceRepositoryAPI(
        gh<_i3.Dio>(),
        gh<_i28.GetCurrentPositionUseCase>(),
      ),
      registerFor: {_prod},
    );
    gh.singleton<_i31.GetPlaceUsecase>(
      () => _i31.GetPlaceUsecase(gh<_i17.IPlaceRepository>()),
      registerFor: {
        _dev,
        _prod,
      },
    );
    gh.singleton<_i32.GetPlacesUseCase>(
        () => _i32.GetPlacesUseCase(gh<_i17.IPlaceRepository>()));
    gh.singleton<_i33.ILaunchChecker>(
        () => _i34.LaunchChecker(gh<_i22.SharedPreferences>()));

    gh.singleton<_i36.LocationBloc>(() => _i36.LocationBloc(
          gh<_i27.GetCurrentCityUseCase>(),
          gh<_i28.GetCurrentPositionUseCase>(),
        ));
    gh.singleton<_i37.LocationV2Bloc>(
        () => _i37.LocationV2Bloc(gh<_i30.GetLocationStreamUsecase>()));
    gh.factory<_i38.PlaceBloc>(
        () => _i38.PlaceBloc(gh<_i31.GetPlaceUsecase>()));
    gh.factory<_i39.PlacesBloc>(() => _i39.PlacesBloc(
          gh<_i32.GetPlacesUseCase>(),
          gh<_i29.GetFiltersUsecase>(),
        ));
    gh.singleton<_i40.SetStatusFirstLaunchUseCase>(
        () => _i40.SetStatusFirstLaunchUseCase(gh<_i33.ILaunchChecker>()));
    gh.lazySingleton<_i41.AuthBloc>(() => _i41.AuthBloc(
          gh<_i23.SignInUseCase>(),
          gh<_i25.SignUpUseCase>(),
          gh<_i26.CheckAuthorizationUseCase>(),
          gh<_i24.SignOutUseCase>(),
        ));
    gh.singleton<_i42.CheckFirstLaunchUseCase>(
        () => _i42.CheckFirstLaunchUseCase(gh<_i33.ILaunchChecker>()));
    gh.singleton<_i43.LaunchBloc>(() => _i43.LaunchBloc(
          gh<_i42.CheckFirstLaunchUseCase>(),
          gh<_i40.SetStatusFirstLaunchUseCase>(),
          gh<_i21.SendRequestLocationPermissionUseCase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i44.RegisterModule {}
