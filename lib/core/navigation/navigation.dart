import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:moreway/core/api/loading_status.dart';
import 'package:moreway/core/di/inject.dart';
import 'package:moreway/module/auth/presentation/bloc/auth_bloc.dart';
import 'package:moreway/module/auth/presentation/page/auth/signin.dart';
import 'package:moreway/module/auth/presentation/page/auth/signup.dart';
import 'package:moreway/module/auth/presentation/page/password/reset_password.dart';
import 'package:moreway/module/auth/presentation/page/password/verify_code.dart';
import 'package:moreway/module/game/presentation/state/rating/rating_bloc.dart';
import 'package:moreway/module/location/presentation/page/map_page.dart';
import 'package:moreway/module/location/presentation/state/location_v2/location_v2_bloc.dart';
import 'package:moreway/module/place/presentation/page/place_detailed_page.dart';
import 'package:moreway/module/place/presentation/state/place/place_bloc.dart';
import 'package:moreway/module/place/presentation/state/places/places_bloc.dart';
import 'package:moreway/module/route/presentation/state/active/active_route_bloc.dart';
import 'package:moreway/module/route/presentation/state/builder/route_builder_bloc.dart';
import 'package:moreway/module/route/presentation/state/route/route_bloc.dart';
import 'package:moreway/module/route/presentation/state/routes/routes_bloc.dart';
import 'package:moreway/module/route/presentation/view/page/route_builder_page.dart';
import 'package:moreway/module/route/presentation/view/page/route_detailed_page.dart';
import 'package:moreway/module/setting/presentation/page/settings_page.dart';
import 'package:moreway/module/user/presentation/state/search/search_users_bloc.dart';
import 'package:moreway/module/user/presentation/state/user/user_bloc.dart';
import 'package:moreway/module/user/presentation/view/page/profile_page.dart';
import 'package:moreway/module/user/presentation/view/page/search_users_page.dart';
import 'package:moreway/module/welcome/presentation/bloc/launch_bloc.dart';
import 'package:moreway/module/welcome/presentation/page/welcome.dart';
import 'package:moreway/core/navigation/root_page.dart';
import 'package:moreway/module/place/presentation/page/home_page.dart';

class AppRouter {
  late final AuthBloc _authBloc;
  late final LaunchBloc _launchBloc;
  late final UserBloc _userBloc;
  late final RouteBuilderBloc _builderBloc;
  late final LocationV2Bloc _locationV2Bloc;
  late final RatingBloc _ratingBloc;
  late GoRouter router;
  final _rootNavigatorKey = GlobalKey<NavigatorState>();

  GetIt get getIt => DIContainer.getIt;

  void setupState() {
    _launchBloc = getIt<LaunchBloc>()..add(CheckFirstLaunchEvent());
    _userBloc = getIt<UserBloc>();
    _builderBloc = getIt<RouteBuilderBloc>();
    _authBloc = getIt<AuthBloc>();
    _locationV2Bloc = getIt<LocationV2Bloc>();
    _ratingBloc = getIt<RatingBloc>();
    _authBloc.stream.listen((state) {
      if (state.status == AuthStatus.authorized) {
        _userBloc.add(LoadUserEvent());
      } else if(state.status == AuthStatus.unauthorized){
        _userBloc.add(ResetUserEvent());
      }
    });
    _userBloc.stream.listen((state) {
      if (state.loadingStatus == LoadingStatus.success) {
        _builderBloc.add(LoadRouteBuilderEvent());
        _locationV2Bloc.add(LocationV2EventLoad());
        _ratingBloc.add(LoadRatingEvent());
      }
    });
    _authBloc.add(AuthCheckAuthorizationEvent());
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
                BlocProvider<RouteBuilderBloc>.value(
                  value: _builderBloc,
                  child: RootPage(navigationShell: navigationShell),
                ),
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
                            BlocProvider<RoutesBloc>(
                              create: (_) =>
                                  getIt<RoutesBloc>()..add(LoadRoutesEvent()),
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
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (_) => getIt<PlaceBloc>()
                                  ..add(PlaceLoadEvent(id: placeId!)),
                              ),
                              BlocProvider.value(
                                value: _builderBloc,
                              ),
                            ],
                            child: const PlaceDetailedPage(),
                          );
                        },
                      ),
                      GoRoute(
                        path: "route/:id",
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) {
                          final routeId = state.pathParameters['id'];
                          return BlocProvider(
                            create: (_) => getIt<RouteBloc>()
                              ..add(RouteLoadEvent(id: routeId!)),
                            child: const RouteDetailedPage(),
                          );
                        },
                      )
                    ]),
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                  path: '/route',
                  builder: (context, state) => const RouteBuilderPage(),
                ),
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                    path: '/map',
                    builder: (context, state) => MultiBlocProvider(providers: [
                          BlocProvider.value(value: _locationV2Bloc),
                          BlocProvider(create: (_) => getIt<ActiveRouteBloc>()..add(LoadActiveRouteEvent()))
                        ], child: const MapPage())),
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
                    builder: (context, state) => MultiBlocProvider(
                          providers: [
                            BlocProvider<UserBloc>.value(
                              value: _userBloc,
                            ),
                            BlocProvider<RatingBloc>.value(
                              value: _ratingBloc,
                            ),
                          ],
                          child: const ProfilePage(),
                        ),
                    routes: [
                      GoRoute(
                        path: "settings",
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) =>
                            BlocProvider<AuthBloc>.value(
                          value: _authBloc,
                          child: const SettingsPage(),
                        ),
                      ),
                      GoRoute(
                        path: "search-users",
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) =>
                            BlocProvider<SearchUsersBloc>(
                          create: (_) => getIt<SearchUsersBloc>(),
                          child: const SearchUsersPage(),
                        ),
                      )
                    ]),
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
