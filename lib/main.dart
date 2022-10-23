import 'dart:io';

import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/common_blocs/common_blocs.dart';
import 'package:dzpos/product/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'core/manager/language/language_manager.dart';
import 'core/manager/route/router.dart';
import 'core/manager/theme/theme_manager.dart';
import 'product/constants/string_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: CommonBloc.blocProviders,
      child: EasyLocalization(
        supportedLocales: LanguageManager.instance.supportedLocales,
        path: LanguageManager.instance.path,
        fallbackLocale: LanguageManager.instance.defaultLanguage,
        saveLocale: true,
        startLocale: const Locale("ar"),
        useOnlyLangCode: true,
        child: ScreenUtilInit(
          builder: (context, child) {
            return child!;
          },
          child: const Dzpos(),
        ),
      ),
    ),
  );
}

class Dzpos extends StatefulWidget {
  const Dzpos({Key? key}) : super(key: key);

  @override
  State<Dzpos> createState() => _DzposState();
}

class _DzposState extends State<Dzpos> with WidgetsBindingObserver {
  @override
  void initState() {
    CommonBloc.applicationBloc.add(SetupApplication());
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    CommonBloc.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.detached) {
      if (StorageKeys.settingsAlwaysBackup.storedValue ?? false) {
        try {
          final dbFolder = await getApplicationDocumentsDirectory();
          final dbPath = p.join(dbFolder.path, 'db.sqlite');
          final file = File(dbPath);
          await CommonBloc.userImpl.uploadDB(db: file);
        } on Exception {
          // TODO
        }
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          // app name
          title: StringConstants.title,

          //theme
          themeMode: ThemeManager.instance.defaultThemeMode,
          theme: ThemeManager.instance.lightTheme,
          darkTheme: ThemeManager.instance.darkTheme,

          // localization
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          // route
          routerConfig: AppRouter.router(
            applicationBloc: context.read<ApplicationBloc>(),
            authBloc: context.read<AuthBloc>(),
          ),
        );
      },
    );
  }
}
