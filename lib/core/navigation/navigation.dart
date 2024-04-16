import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/di/inject.dart';
import 'package:moreway/module/auth/presentation/bloc/auth_bloc.dart';
import 'package:moreway/module/auth/presentation/page/auth/signin.dart';
import 'package:moreway/module/auth/presentation/page/auth/signup.dart';
import 'package:moreway/module/auth/presentation/page/password/reset_password.dart';
import 'package:moreway/module/auth/presentation/page/password/verify_code.dart';
import 'package:moreway/module/location/presentation/state/bloc/location_bloc.dart';
import 'package:moreway/module/map/presentation/page/map_page.dart';
import 'package:moreway/module/place/presentation/state/bloc/places_bloc.dart';
import 'package:moreway/module/welcome/presentation/bloc/launch_bloc.dart';
import 'package:moreway/module/welcome/presentation/page/welcome.dart';
import 'package:moreway/core/navigation/root_page.dart';
import 'package:moreway/module/place/presentation/page/home_page.dart';
import 'package:moreway/module/test/test_settings_page.dart';

class AppRouter {
  late final AuthBloc _authBloc;
  late final LaunchBloc _launchBloc;
  late GoRouter router;

  AppRouter() {
    _authBloc = getIt<AuthBloc>();
    _launchBloc = getIt<LaunchBloc>()..add(CheckFirstLaunchEvent());
    initRouter();
  }

  void initRouter() {
    router = GoRouter(
        //debugLogDiagnostics: true,
        initialLocation: "/home",
        routes: [
          GoRoute(
            path: WelcomePage.path,
            name: WelcomePage.name,
            builder: (context, state) {
              return WelcomePage.create();
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
              routes: [
                GoRoute(
                    path: "reset-password",
                    builder: (context, state) {
                      return EmailForResetPasswordPage();
                    },
                    routes: [
                      GoRoute(
                          path: "verify-code",
                          builder: (context, state) {
                            return const VerifyCodePage();
                          },
                          routes: const []),
                    ]),
              ]),
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
                      builder: (context, state) => MultiBlocProvider(
                            providers: [
                              BlocProvider<PlacesBloc>(
                                create: (_) => getIt<PlacesBloc>(),
                              ),
                              BlocProvider.value(
                                value: getIt<LocationBloc>(),
                              ),
                            ],
                            child: const HomePage(),
                          )),
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
                      builder: (context, state) => BlocProvider.value(
                          value: getIt<LocationBloc>(), child: MapPage())),
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
                      builder: (context, state) => BlocProvider<AuthBloc>.value(
                            value: _authBloc,
                            child: const TestSettingsPage(),
                          )),
                ]),
              ]),
        ],
        redirect: redirect);
  }

  String? redirect(BuildContext context, GoRouterState state) {
    final isFirstLaunchGuard = firstLaunchMiddleware(context, state);
    if (isFirstLaunchGuard != null) {
      return isFirstLaunchGuard;
    }
    final isAuthenticationGuard = authorizationMiddleware(context, state);
    if (isAuthenticationGuard != null) {
      return isAuthenticationGuard;
    }
    return null;
  }

  String? firstLaunchMiddleware(BuildContext context, GoRouterState state) {
    final isFirstLaunch = _launchBloc.state.isFirstLaunch;
    if (isFirstLaunch) {
      return state.namedLocation(WelcomePage.name);
    }
    return null;
  }

  String? authorizationMiddleware(BuildContext context, GoRouterState state) {
    final isAuthorized = _authBloc.state.status == AuthStatus.authorized;
    final isAuthenticating = state.matchedLocation.contains("/signin") ||
        state.matchedLocation.contains("/signup");
    if (!isAuthorized && !isAuthenticating) {
      return '/signin';
    }
    return null;
  }
}
