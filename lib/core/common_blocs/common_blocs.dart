import 'application/application_bloc.dart';
import 'profile/profile_bloc.dart';
import 'theme/theme_bloc.dart';
import '../services/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application_layer/application_layer.dart';
import '../../data/data.dart';
import 'printer/printer_bloc.dart';

export 'application/application_bloc.dart';
export 'theme/theme_bloc.dart';

class CommonBloc {
  static final db = MyDatabase();
  // Daos
  static final accountsDao = AccountsDao(db);
  static final invoicesDao = InvoicesDao(db);
  // Blocs
  static final userImpl = UserRepositoryImpl();
  static final authImpl = AuthRepositoryImpl();
  static final applicationBloc = ApplicationBloc();
  static final authBloc = AuthBloc(authImpl, userImpl);
  static final phoneAuthBloc = PhoneAuthBloc(authImpl);
  static final themeBloc = ThemeBloc();
  static final profileBloc = ProfileBloc(authImpl, userImpl);
  static final printerBloc = PrinterBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<ApplicationBloc>(
      create: (context) => applicationBloc,
    ),
    BlocProvider<AuthBloc>(
      create: (context) => authBloc,
    ),
    BlocProvider<ThemeBloc>(
      create: (context) => themeBloc,
    ),
    BlocProvider<PrinterBloc>(
      create: (context) => printerBloc,
    ),
    BlocProvider<PhoneAuthBloc>(
      create: (context) => phoneAuthBloc,
    ),
    BlocProvider<ProfileBloc>(
      create: (context) => profileBloc,
    ),
  ];

  /// Dispose
  static void dispose() {
    applicationBloc.close();
    themeBloc.close();
    authBloc.close();
    phoneAuthBloc.close();
    printerBloc.close();
    profileBloc.close();
  }

  /// Singleton factory
  static final CommonBloc _instance = CommonBloc._internal();

  factory CommonBloc() {
    return _instance;
  }
  CommonBloc._internal();
}
