import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/module/auth/presentation/page/welcome.dart';
import 'package:moreway/module/place/presentation/page/main_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) {
          return const WelcomePage();
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => RootPage(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const Scaffold(body: Center(child: Text("home"))),
              ),
            ]
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/route',
                builder: (context, state) => const Scaffold(body: Center(child: Text("route"))),
              ),
            ]
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/map',
                builder: (context, state) => const Scaffold(body: Center(child: Text("map"))),
              ),
            ]
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chat',
                builder: (context, state) => const Scaffold(body: Center(child: Text("chat"))),
              ),
            ]
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const Scaffold(body: Center(child: Text("profile"))),
              ),
            ]
          ),
        ]
      )
    ]
  );
}