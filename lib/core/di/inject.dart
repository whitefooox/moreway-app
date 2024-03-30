import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'inject.config.dart';

final getIt = GetIt.instance;  
  
@InjectableInit(  
  initializerName: 'init', 
  preferRelativeImports: true, 
  asExtension: true,
)  
Future<void> configureDependencies() async => await getIt.init();

@module
abstract class RegisterModule {
  @singleton 
  Dio get dio => Dio();

  @singleton  
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @preResolve
  Future<SharedPreferences> get sharedPreferences => SharedPreferences.getInstance();
}
