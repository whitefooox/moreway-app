import 'package:flutter/material.dart';
import 'package:moreway/core/theme/theme.dart';
import 'package:moreway/core/navigation/navigation.dart';

class App extends StatelessWidget {

  final AppRouter _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.router,
      theme: appThemeData
    );
  }
}
