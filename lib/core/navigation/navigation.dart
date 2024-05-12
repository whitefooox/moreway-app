import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/di/inject.dart';
import 'package:moreway/module/auth/presentation/bloc/auth_bloc.dart';
import 'package:moreway/module/auth/presentation/page/auth/signin.dart';
import 'package:moreway/module/auth/presentation/page/auth/signup.dart';
import 'package:moreway/module/auth/presentation/page/password/reset_password.dart';
import 'package:moreway/module/auth/presentation/page/password/verify_code.dart';
import 'package:moreway/module/location/presentation/state/location/location_bloc.dart';
import 'package:moreway/module/location/presentation/page/map_page.dart';
import 'package:moreway/module/location/presentation/state/location_v2/location_v2_bloc.dart';
import 'package:moreway/module/place/presentation/page/place_view_page.dart';
import 'package:moreway/module/place/presentation/state/place/place_bloc.dart';
import 'package:moreway/module/place/presentation/state/places/places_bloc.dart';
import 'package:moreway/module/user/presentation/state/bloc/user_bloc.dart';
import 'package:moreway/module/user/presentation/view/page/profile_page.dart';
import 'package:moreway/module/welcome/presentation/bloc/launch_bloc.dart';
import 'package:moreway/module/welcome/presentation/page/welcome.dart';
import 'package:moreway/core/navigation/root_page.dart';
import 'package:moreway/module/place/presentation/page/home_page.dart';
import 'package:moreway/module/test/test_settings_page.dart';

class AppRouter {
  late final AuthBloc _authBloc;
  late final LaunchBloc _launchBloc;
  late GoRouter router;
  final _rootNavigatorKey = GlobalKey<NavigatorState>();

  GetIt get getIt => DIContainer.getIt;

  void setupState() {
    _authBloc = getIt<AuthBloc>()..add(AuthCheckAuthorizationEvent());
    _launchBloc = getIt<LaunchBloc>()..add(CheckFirstLaunchEvent());
  }

  AppRouter() {
    setupState();
    initRouter();
  }

  GoRoute _buildWelcomePage() {
    return GoRoute(
      path: "/welcome",
      name: "welcome",
      builder: (context, state) {
        return BlocProvider<LaunchBloc>.value(
          value: getIt<LaunchBloc>(),
          child: const WelcomePage(),
        );
      },
    );
  }

  GoRoute _buildSigninPage({List<GoRoute> routes = const []}) {
    return GoRoute(
        path: "/signin",
        builder: (context, state) {
          return BlocProvider<AuthBloc>.value(
            value: _authBloc,
            child: const SignInPage(),
          );
        },
        routes: routes);
  }

  void initRouter() {
    router = GoRouter(
      //debugLogDiagnostics: true,
      initialLocation: "/home",
      navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
          path: "/loading",
          builder: (context, state) => BlocListener<AuthBloc, AuthState>(
            bloc: _authBloc,
            listener: (context, state) {
              if(state.status != AuthStatus.loading){
                context.go("/home");
              }
            },
            child: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
        _buildWelcomePage(),
        _buildSigninPage(routes: [
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
            //parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state, navigationShell) =>
                RootPage(navigationShell: navigationShell),
            branches: [
              StatefulShellBranch(routes: [
                GoRoute(
                    path: '/home',
                    builder: (context, state) => MultiBlocProvider(
                          providers: [
                            BlocProvider<PlacesBloc>(
                              create: (_) => getIt<PlacesBloc>()
                                ..add(LoadPlacesAndFiltersEvent()),
                            ),
                            BlocProvider.value(
                              value: getIt<LocationBloc>()
                                ..add(GetCurrentLocationEvent()),
                            ),
                          ],
                          child: const HomePage(),
                        ),
                    routes: [
                      GoRoute(
                        path: "place/:id",
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) {
                          final placeId = state.pathParameters['id'];
                          return BlocProvider(
                            create: (_) => getIt<PlaceBloc>()
                              ..add(PlaceLoadEvent(id: placeId!)),
                            child: const PlaceViewPage(),
                          );
                        },
                      )
                    ]),
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
                        value: getIt<LocationV2Bloc>()
                          ..add(LocationV2EventLoad()),
                        child: const MapPage())),
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
                          child: ProfilePage(),
                        )),
              ]),
            ]),
      ],
      redirect: redirect,
    );
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
      return state.namedLocation("welcome");
    }
    return null;
  }

  String? authorizationMiddleware(BuildContext context, GoRouterState state) {
    final isAuthorized = _authBloc.state.status == AuthStatus.authorized;
    final isLoading = _authBloc.state.status == AuthStatus.loading;
    final isAuthenticating = state.matchedLocation.contains("/signin") ||
        state.matchedLocation.contains("/signup");
    if (isLoading) {
      return "/loading";
    }
    if (!isAuthorized && !isAuthenticating) {
      return '/signin';
    }
    return null;
  }
}
