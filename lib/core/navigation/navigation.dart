import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/module/auth/presentation/bloc/auth_bloc.dart';
import 'package:moreway/module/auth/presentation/page/signin.dart';
import 'package:moreway/module/auth/presentation/page/signup.dart';
import 'package:moreway/module/auth/presentation/page/welcome.dart';
import 'package:moreway/core/navigation/root_page.dart';

class AppRouter {
  final AuthBloc _authBloc;
  late GoRouter router;

  AppRouter(this._authBloc) {
    _authBloc.add(AuthCheckAuthorizationEvent());
    initRouter();
  }

  void initRouter() {
    router = GoRouter(
        initialLocation: '/signin',
        routes: [
          GoRoute(
            path: "/",
            builder: (context, state) {
              return const WelcomePage();
            },
          ),
          GoRoute(
            path: "/signin",
            builder: (context, state) {
              return BlocProvider<AuthBloc>.value(
                value: _authBloc,
                child: const SignInPage(),
              );
            },
          ),
          GoRoute(
            path: "/signup",
            builder: (context, state) {
              return BlocProvider<AuthBloc>.value(
                value: _authBloc,
                child: const SignUpPage(),
              );
            },
          ),
          StatefulShellRoute.indexedStack(
              builder: (context, state, navigationShell) =>
                  RootPage(navigationShell: navigationShell),
              branches: [
                StatefulShellBranch(routes: [
                  GoRoute(
                    path: '/home',
                    builder: (context, state) =>
                        const Scaffold(body: Center(child: Text("home"))),
                  ),
                ]),
                StatefulShellBranch(routes: [
                  GoRoute(
                    path: '/route',
                    builder: (context, state) =>
                        const Scaffold(body: Center(child: Text("route"))),
                  ),
                ]),
                StatefulShellBranch(routes: [
                  GoRoute(
                    path: '/map',
                    builder: (context, state) =>
                        const Scaffold(body: Center(child: Text("map"))),
                  ),
                ]),
                StatefulShellBranch(routes: [
                  GoRoute(
                    path: '/chat',
                    builder: (context, state) =>
                        const Scaffold(body: Center(child: Text("chat"))),
                  ),
                ]),
                StatefulShellBranch(routes: [
                  GoRoute(
                    path: '/profile',
                    builder: (context, state) =>
                        const Scaffold(body: Center(child: Text("profile"))),
                  ),
                ]),
              ]),
        ],
        redirect: redirect);
  }

  String? redirect(BuildContext context, GoRouterState state) {
    final isAuthorized = _authBloc.state.status == AuthStatus.authorized;
    final isUnauthorizedRoute = state.fullPath == '/' || state.fullPath == '/signin' || state.fullPath == '/signup';
    
    if (!isAuthorized && !isUnauthorizedRoute) {
      return '/signin';
    }

    return null;
  }
}
