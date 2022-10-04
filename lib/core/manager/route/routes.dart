import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../application_layer/application_layer.dart';

enum AppRoutes {
  auth('/auth', 'Auth', AuthPage()),
  login('login', 'LOGIN', LoginPage()),
  register('register', 'REGISTER', RegisterPage()),
  phoneOTP('phoneOTP', 'PHONEOTP', PhoneOTPPage()),
  splash("/splash", "SPLASH", SplashPage()),
  home('/home', 'HOME', HomePage());

  const AppRoutes(this.routePath, this.routeName, this.routeView);
  final String routePath;
  final String routeName;
  final Widget routeView;

  @override
  String toString() => '$name: [$routePath][$routeName][$routeView]';

  GoRoute goRoute([List<RouteBase>? routes]) {
    return GoRoute(
      path: routePath,
      name: routeName,
      routes: routes ?? [],
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: routeView,
        );
      },
    );
  }
}
