import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:moreway/core/api/api_client.dart';
import 'package:moreway/module/auth/data/repository/auth_service_api.dart';
import 'package:moreway/module/auth/data/repository/token_secure_storage.dart';
import 'package:moreway/module/auth/domain/dependency/i_auth_service.dart';
import 'package:moreway/module/auth/domain/dependency/i_token_storage.dart';
import 'package:moreway/module/auth/domain/usecase/auth_interactor.dart';
import 'package:moreway/module/auth/presentation/bloc/auth_bloc.dart';
import 'package:moreway/module/location/data/geolocator_service.dart';
import 'package:moreway/module/location/data/osm_geoincoder.dart';
import 'package:moreway/module/location/data/permission_service.dart';
import 'package:moreway/module/location/domain/dependency/i_geoincoder_service.dart';
import 'package:moreway/module/location/domain/dependency/i_location_permission_service.dart';
import 'package:moreway/module/location/domain/dependency/i_location_service.dart';
import 'package:moreway/module/location/domain/usecase/get_current_city.dart';
import 'package:moreway/module/location/domain/usecase/get_current_location.dart';
import 'package:moreway/module/location/domain/usecase/get_location_stream.dart';
import 'package:moreway/module/location/domain/usecase/send_request_location_permission.dart';
import 'package:moreway/module/location/presentation/state/location/location_bloc.dart';
import 'package:moreway/module/location/presentation/state/location_v2/location_v2_bloc.dart';
import 'package:moreway/module/place/data/filter_repository_api.dart';
import 'package:moreway/module/place/data/place_repository_api.dart';
import 'package:moreway/module/place/domain/dependency/i_filter_repository.dart';
import 'package:moreway/module/place/domain/dependency/i_place_repository.dart';
import 'package:moreway/module/place/domain/usecase/get_filters.dart';
import 'package:moreway/module/place/domain/usecase/get_place.dart';
import 'package:moreway/module/place/domain/usecase/get_places.dart';
import 'package:moreway/module/place/presentation/state/place/place_bloc.dart';
import 'package:moreway/module/place/presentation/state/places/places_bloc.dart';
import 'package:moreway/module/user/data/user_repository_api.dart';
import 'package:moreway/module/user/domain/dependency/i_user_repository.dart';
import 'package:moreway/module/user/domain/interactor/user_interactor.dart';
import 'package:moreway/module/user/presentation/state/bloc/user_bloc.dart';
import 'package:moreway/module/welcome/data/launch_checker.dart';
import 'package:moreway/module/welcome/domain/dependency/i_launch_checker.dart';
import 'package:moreway/module/welcome/domain/usecase/check_first_launch.dart';
import 'package:moreway/module/welcome/domain/usecase/set_status_first_launch.dart';
import 'package:moreway/module/welcome/presentation/bloc/launch_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DIContainer {
  static GetIt get getIt => GetIt.instance;

  Future<void> inject() async {
    getIt.registerFactory<Dio>(() => Dio());
    getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
    getIt.registerSingletonAsync<SharedPreferences>(
        () => SharedPreferences.getInstance());
    _injectAuth();
    _injectUser();
    _injectLocation();
    _injectPlace();
    _injectLaunch();
    await getIt.allReady();
  }

  void _injectAuth() {
    getIt.registerLazySingleton<ITokenStorage>(
        () => TokenSecureStorage(getIt()));
    getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt(), getIt()));
    getIt.registerLazySingleton<IAuthService>(() => AuthServiceAPI(getIt()));
    // getIt.registerLazySingleton<IAuthService>(() => AuthServiceMock(),
    //     instanceName: "AuthServiceMock");
    getIt.registerLazySingleton<AuthInteractor>(
        () => AuthInteractor(getIt(), getIt()));
    getIt.registerLazySingleton<AuthBloc>(() => AuthBloc(getIt()));
  }

  void _injectLocation() {
    getIt.registerSingleton<ILocationService>(GeolocatorService());
    getIt.registerLazySingleton<IGeoincoderService>(
        () => OSMGeoincoderService(getIt()));
    getIt.registerSingleton<ILocationPermissionService>(
        GeolocatorPermissionService());
    getIt.registerLazySingleton<GetCurrentCityUseCase>(
        () => GetCurrentCityUseCase(getIt(), getIt(), getIt()));
    getIt.registerLazySingleton<GetCurrentPositionUseCase>(
        () => GetCurrentPositionUseCase(getIt(), getIt()));
    getIt.registerLazySingleton<GetLocationStreamUsecase>(
        () => GetLocationStreamUsecase(getIt(), getIt()));
    getIt.registerLazySingleton<SendRequestLocationPermissionUseCase>(
        () => SendRequestLocationPermissionUseCase(getIt()));
    getIt.registerLazySingleton<LocationBloc>(
        () => LocationBloc(getIt(), getIt()));
    getIt.registerLazySingleton<LocationV2Bloc>(() => LocationV2Bloc(getIt()));
  }

  void _injectPlace() {
    getIt.registerLazySingleton<IFilterRepository>(
        () => FilterRepositoryAPI(getIt()));
    getIt.registerLazySingleton<IPlaceRepository>(
        () => PlaceRepositoryAPI(getIt(), getIt()));
    getIt
        .registerLazySingleton<GetPlaceUsecase>(() => GetPlaceUsecase(getIt()));
    getIt.registerLazySingleton<GetFiltersUsecase>(
        () => GetFiltersUsecase(getIt()));
    getIt.registerLazySingleton<GetPlacesUseCase>(
        () => GetPlacesUseCase(getIt()));
    getIt.registerFactory<PlacesBloc>(() => PlacesBloc(getIt(), getIt()));
    getIt.registerFactory<PlaceBloc>(() => PlaceBloc(getIt(), getIt()));
  }

  void _injectLaunch() {
    getIt.registerLazySingleton<ILaunchChecker>(() => LaunchChecker(getIt()));
    getIt.registerLazySingleton<CheckFirstLaunchUseCase>(
        () => CheckFirstLaunchUseCase(getIt()));
    getIt.registerLazySingleton<SetStatusFirstLaunchUseCase>(
        () => SetStatusFirstLaunchUseCase(getIt()));
    getIt.registerLazySingleton(() => LaunchBloc(getIt(), getIt(), getIt()));
  }

  //dependency: api
  void _injectUser(){
    getIt.registerLazySingleton<IUserRepository>(() => UserRepositoryAPI(getIt()));
    getIt.registerLazySingleton<UserInteractor>(() => UserInteractor(getIt()));
    getIt.registerLazySingleton<UserBloc>(() => UserBloc(getIt()));
  }
}
