import 'package:dzpos/core/common_blocs/application/application_bloc.dart';
import 'package:dzpos/core/common_blocs/theme/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application_layer/application_layer.dart';
import '../../data/data.dart';

export 'application/application_bloc.dart';
export 'theme/theme_bloc.dart';

class CommonBloc {
  // Blocs
  static final applicationBloc = ApplicationBloc();
  static final authBloc = AuthBloc(AuthRepositoryImpl());
  static final themeBloc = ThemeBloc();

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
  ];

  /// Dispose
  static void dispose() {
    applicationBloc.close();
    themeBloc.close();
    authBloc.close();
  }

  /// Singleton factory
  static final CommonBloc _instance = CommonBloc._internal();

  factory CommonBloc() {
    return _instance;
  }
  CommonBloc._internal();
}
