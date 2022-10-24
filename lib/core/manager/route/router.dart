import 'dart:async';

import 'package:dzpos/core/common_blocs/profile/profile_bloc.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../application_layer/application_layer.dart';
import '../../common_blocs/common_blocs.dart';
import '../../enums.dart';
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
            AppRoutes.invoices.goRoute([
              AppRoutes.newInvoice.goRoute(
                [],
                (context, state) {
                  final type =
                      InvoiceType.stringToType(state.params["type"] ?? "");
                  return MaterialPage(
                    key: state.pageKey,
                    child: BlocProvider(
                      create: (context) => NewInvoiceCubit(
                        invoicesRepository,
                        invoice: state.extra as FullInvoice?,
                      ),
                      child: NewInvoicePage(
                        type: type,
                      ),
                    ),
                  );
                },
              ),
              AppRoutes.showInvoices.goRoute(),
              AppRoutes.totalDailyInvoicesReports.goRoute(),
              AppRoutes.pricingPolicy.goRoute(),
              AppRoutes.listOfMaterials.goRoute(),
              AppRoutes.product.goRoute(
                [],
                (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: ProductPage(
                      product: state.extra as FullProduct?,
                    ),
                  );
                },
              ),
            ]),
            AppRoutes.accounts.goRoute([
              AppRoutes.newAccount.goRoute([], (context, state) {
                return MaterialPage(
                  key: state.pageKey,
                  child: NewAccountPage(
                    account: state.extra as Account?,
                  ),
                );
              }),
              AppRoutes.accountsList.goRoute(),
              AppRoutes.debtList.goRoute(),
              AppRoutes.accountStatement.goRoute(),
              AppRoutes.debt.goRoute(
                [],
                (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: DebtPage(
                      type: state.extra as DebtType?,
                    ),
                  );
                },
              )
            ]),
            AppRoutes.reports.goRoute(),
            AppRoutes.settings.goRoute([
              AppRoutes.defaultPrint.goRoute(),
              AppRoutes.printLabels.goRoute(),
              AppRoutes.printingPreview.goRoute(),
              AppRoutes.printerModel.goRoute(),
            ]),
          ], (context, goState) {
            CommonBloc.profileBloc.add(LoadProfile());
            print("path : ${goState.path}");
            return MaterialPage(
              key: goState.pageKey,
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  print("profile bloc rebuild $state");
                  if (state is ProfileLoaded) {
                    if (state.loggedUser.isNotEmpty) {
                      final user = state.loggedUser;
                      final localImei =
                          CommonBloc.applicationBloc.application.imei;
                      if (localImei != null) {
                        if (user.devices.isEmpty) {
                          CommonBloc.authBloc.add(AddDeviceImei(localImei));
                        } else {
                          if (user.devices.contains(localImei)) {
                            if (user.isActive) {
                              return AppRoutes.home.view;
                            } else {
                              return const UserNotActive();
                            }
                          } else if (user.devices.length < user.maxDevices) {
                            CommonBloc.authBloc.add(AddDeviceImei(localImei));
                          } else {
                            CommonBloc.authBloc.add(
                              SignOutRequested(
                                  CommonBloc.applicationBloc.application.imei),
                            );
                          }
                        }
                      }
                    } else {
                      CommonBloc.authBloc.add(
                        SignOutRequested(
                            CommonBloc.applicationBloc.application.imei),
                      );
                    }
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
              print(state.subloc);
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
