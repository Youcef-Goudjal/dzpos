import 'dart:async';

import '../../../application_layer/application_layer.dart';
import '../common_blocs.dart';
import 'package:equatable/equatable.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/product.dart';
import '../profile/profile_bloc.dart';

part 'application_event.dart';
part 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final application = Application();
  ApplicationBloc() : super(ApplicationInitial()) {
    on<SetupApplication>(_onSetupApplication);
    on<ApplicationWillClose>(_onApplicationWillClose);
  }

  Future<void> _onSetupApplication(
      SetupApplication event, Emitter<ApplicationState> emit) async {
    /// setup Shared preferences
    await application.setPreferences();

    /// get  settings
    final oldTheme = Application.pref.getString(StorageKeys.theme.name);
    final oldThemeMode = Application.pref.getString(StorageKeys.themeMode.name);
    FlexScheme? theme;
    ThemeMode? themeMode;
    if (oldTheme != null) {
      theme = FlexScheme.values.byName(oldTheme.split(".").last);
    }
    if (oldThemeMode != null) {
      themeMode = ThemeMode.values.byName(oldThemeMode.split(".").last);
    }

    if (theme != null || themeMode != null) {
      CommonBloc.themeBloc.add(ThemeChanged(
        flexScheme: theme,
        themeMode: themeMode,
      ));
    }

    /// Authentication beging check
    CommonBloc.authBloc.add(AuthenticationStarted());

    // check Authentication
    emit(ApplicationCompleted());
  }

  FutureOr<void> _onApplicationWillClose(
      ApplicationWillClose event, Emitter<ApplicationState> emit) {
    print('Application closed');
    if (StorageKeys.settingsAlwaysBackup.storedValue ?? false) {
      CommonBloc.profileBloc.add(UploadDBRequested());
    }
  }
}
