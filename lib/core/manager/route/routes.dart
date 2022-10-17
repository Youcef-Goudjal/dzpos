import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../application_layer/application_layer.dart';

enum AppRoutes {
  auth('/auth', 'Auth', AuthPage()),
  login('login', 'LOGIN', LoginPage()),
  loginPhone('loginPhone', 'LoginPhone', LoginPhonePage()),
  forgotPassword('forgotPassword', 'FORGOTPASSWORD', ForgotPasswordPage()),
  resetPassword('resetPassword', 'ResetPASSWORD', ResetPasswordPage()),
  register('register', 'REGISTER', RegisterPage()),
  verifyOtp('verifyOtp', 'VerifyOtp', VerifyOTPPage()),
  splash("/splash", "SPLASH", SplashPage()),
  home('/home', 'HOME', HomePage()),
  invoices("invoices", "Invoices", InvoicesPage()),
  newInvoice("newInvoice/:type", "NewInvoice", NewInvoicePage()),
  listOfMaterials("listOfMaterials", "ListOfMaterials", ListOfMaterialsPage()),
  product("product", "Product", ProductPage()),
  settings("settings", "Settings", SettingsPage()),
  accounts("accounts", "Accounts", AccountsPage()),
  newAccount("newAccount", "NewAccount", NewAccountPage()),
  accountsList("accountsList", "AccountsList", AccountsListPage()),
  accountStatement(
      "accountStatement", "AccountStatement", AccountStatementPage()),
  debt("debt", "Debt", DebtPage()),

  debtList("debtList", "DebtList", DebtListPage()),
  reports("reports", "Reports", ReportsPage());

  const AppRoutes(this.path, this.name, this.view);
  final String path;
  final String name;
  final Widget view;

  @override
  String toString() => '$name: [$path][$name][$view]';

  GoRoute goRoute([
    List<RouteBase>? routes,
    Page<dynamic> Function(BuildContext, GoRouterState)? pageBuilder,
  ]) {
    return GoRoute(
      path: path,
      name: name,
      routes: routes ?? [],
      pageBuilder: pageBuilder ??
          (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: view,
            );
          },
    );
  }
}
