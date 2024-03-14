// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:moreway/core/const/colors.dart';
import 'package:moreway/core/const/styles.dart';
import 'package:moreway/core/navigation/navigation.dart';

class App extends StatelessWidget {

  final AppRouter _appRouter;

  const App(
    this._appRouter,
    {Key? key,}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.router,
      theme: ThemeData(
        fontFamily: "Poppins",
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: AppColor.black,
          selectedItemColor: AppColor.white,
          unselectedItemColor: AppColor.white.withOpacity(0.5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: Styles.blButtonStyle
        ),
      ),
    );
  }
}
