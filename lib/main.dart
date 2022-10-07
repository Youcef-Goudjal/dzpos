import 'package:dzpos/application_layer/application_layer.dart';
import 'package:dzpos/core/common_blocs/common_blocs.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/product/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    RepositoryProvider(
      create: (context) => MyDatabase(),
      
      child: MultiBlocProvider(
        providers: CommonBloc.blocProviders,
        child: EasyLocalization(
          supportedLocales: LanguageManager.instance.supportedLocales,
          path: LanguageManager.instance.path,
          fallbackLocale: LanguageManager.instance.defaultLanguage,
          saveLocale: true,
          useOnlyLangCode: true,
          child: ScreenUtilInit(
            builder: (context, child) {
              return child!;
            },
            child: const Dzpos(),
          ),
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

class _DzposState extends State<Dzpos> {
  @override
  void initState() {
    CommonBloc.applicationBloc.add(SetupApplication());
    super.initState();
  }

  @override
  void dispose() {
    CommonBloc.dispose();
    super.dispose();
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
