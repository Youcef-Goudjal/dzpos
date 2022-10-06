import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../application_layer/application_layer.dart';
import '../../common_blocs/common_blocs.dart';
import 'routes.dart';

abstract class AppRouter {
  static GoRouter router({
    required AuthBloc authBloc,
    required ApplicationBloc applicationBloc,
  }) =>
      GoRouter(
        observers: [GoRouterObserver()],
        initialLocation: AppRoutes.splash.routePath,
        routes: [
          AppRoutes.home.goRoute(),
          AppRoutes.auth.goRoute([
            AppRoutes.loginPhone.goRoute(),
            AppRoutes.verifyOtp.goRoute(),
            AppRoutes.login.goRoute([
              AppRoutes.forgotPasswort.goRoute(),
              AppRoutes.resetPasswort.goRoute()
            ]),
            AppRoutes.register.goRoute(),
          ]),
          AppRoutes.splash.goRoute(),
        ],
        // Refreshes its current route when the stream receives an event
        refreshListenable: GoRouterRefreshStream(
          authBloc.stream,
        ),
        redirect: (context, state) {
          if (authBloc.state is Unauthenticated) {
            if (!state.subloc.startsWith(AppRoutes.auth.routePath)) {
              return AppRoutes.auth.routePath;
            }
          }
          if (authBloc.state is Authenticated) {
            if (!state.subloc.startsWith(AppRoutes.home.routePath)) {
              return AppRoutes.home.routePath;
            }
          }
          if (authBloc.state is AuthError) {
            return null;
          }

          return null;
        },
      );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream stream) {
    stream.asBroadcastStream().listen((event) {
      notifyListeners();
      print("state $event");
    });
  }
}

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('PUSHED SCREEN: ${route.settings.name}'); //name comes back null
  }
}
