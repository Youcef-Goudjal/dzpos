import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../application_layer/application_layer.dart';

enum AppRoutes {
  auth('/auth', 'Auth', AuthPage()),
  login('login', 'LOGIN', LoginPage()),
  loginPhone('loginPhone', 'LoginPhone', LoginPhonePage()),
  forgotPasswort('forgotPassword', 'FORGOTPASSWORD', ForgotPasswordPage()),
  resetPasswort('resetPassword', 'ResetPASSWORD', ResetPasswordPage()),
  register('register', 'REGISTER', RegisterPage()),
  verifyOtp('verifyOtp', 'VerifyOtp', VerifyOTPPage()),
  splash("/splash", "SPLASH", SplashPage()),
  home('/', 'HOME', HomePage());

  const AppRoutes(this.routePath, this.routeName, this.routeView);
  final String routePath;
  final String routeName;
  final Widget routeView;

  @override
  String toString() => '$name: [$routePath][$routeName][$routeView]';

  GoRoute goRoute([
    List<RouteBase>? routes,
    Page<dynamic> Function(BuildContext, GoRouterState)? pageBuilder,
  ]) {
    return GoRoute(
      path: routePath,
      name: routeName,
      routes: routes ?? [],
      pageBuilder: pageBuilder ??
          (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: routeView,
            );
          },
    );
  }
}
