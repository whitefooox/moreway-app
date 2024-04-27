import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:moreway/core/api/api_client.dart';
import 'package:moreway/core/app.dart';
import 'package:moreway/core/di/inject.dart';
import 'package:moreway/module/auth/domain/dependency/i_token_storage.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await setupApp();
    runApp(App());
    FlutterNativeSplash.remove();
  }, (error, stack) {
    log(error.toString());
  });
}

Future<void> setupApp() async {
  final getIt = GetIt.instance;
  await DIContainer().inject();
  //await configureDependencies(Env.prod);
  setupApiClient(getIt<ITokenStorage>(), getIt<Dio>());
  setupOrientation();
  setupSystemUI();
}

void setupOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void setupSystemUI() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
}
