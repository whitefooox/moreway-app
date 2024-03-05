import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moreway/core/const/colors.dart';
import 'package:moreway/core/const/styles.dart';
import 'package:moreway/core/navigation/navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 786),
      builder: (_, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
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
          )
        ),
      ),
    );
  }
}
