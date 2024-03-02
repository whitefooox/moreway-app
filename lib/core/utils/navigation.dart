import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/module/auth/presentation/page/welcome.dart';
import 'package:moreway/module/place/presentation/page/test_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) {
          return WelcomePage();
        },
      )
    ]
  );
}