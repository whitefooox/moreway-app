import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:moreway/core/app.dart';
import 'package:moreway/core/di/di_container.dart';
import 'package:moreway/core/navigation/navigation.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final diContainer = DIContainer();
  diContainer.buildDependencies();
  final router = GetIt.instance.get<AppRouter>();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(App(router));
  FlutterNativeSplash.remove();
}