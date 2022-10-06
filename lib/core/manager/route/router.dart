import 'dart:async';

import 'package:dzpos/core/common_blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        initialLocation: AppRoutes.splash.path,
        routes: [
          AppRoutes.home.goRoute([
            AppRoutes.invoices.goRoute(),
            AppRoutes.accounts.goRoute(),
            AppRoutes.reports.goRoute(),
            AppRoutes.settings.goRoute(),
          ], (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    // TODO: handel if the client profile is activate
                    return AppRoutes.home.view;
                  }
                  return AppRoutes.splash.view;
                },
              ),
            );
          }),
          AppRoutes.auth.goRoute([
            AppRoutes.loginPhone.goRoute(),
            AppRoutes.verifyOtp.goRoute(),
            AppRoutes.login.goRoute([
              AppRoutes.forgotPassword.goRoute(),
              AppRoutes.resetPassword.goRoute()
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
            if (!state.subloc.startsWith(AppRoutes.auth.path)) {
              return AppRoutes.auth.path;
            }
          }
          if (authBloc.state is Authenticated) {
            if (state.subloc.contains(AppRoutes.register.path) ||
                state.subloc.contains(AppRoutes.verifyOtp.path)) {
              return null;
            }
            if (!state.subloc.startsWith(AppRoutes.home.path)) {
              CommonBloc.profileBloc.add(LoadProfile());
              return AppRoutes.home.path;
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
