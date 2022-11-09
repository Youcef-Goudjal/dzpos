import 'dart:async';

import '../../manager/theme/theme_manager.dart';
import '../../../product/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(InitialThemeState()) {
    on<ThemeChanged>(_onThemeChanged);
  }

  Future<void> _onThemeChanged(
      ThemeChanged event, Emitter<ThemeState> emit) async {
    if (event.flexScheme == ThemeManager.instance.defaultFlexScheme ||
        event.themeMode == ThemeManager.instance.defaultThemeMode) {
      emit(ThemeUpdated());
    } else {
      emit(ThemeUpdating());
      if (event.flexScheme != null) {
        ThemeManager.instance.defaultFlexScheme = event.flexScheme!;
        await Application.pref
            .setString(StorageKeys.theme.name, "${event.flexScheme}");
      }
      if (event.themeMode != null) {
        ThemeManager.instance.defaultThemeMode = event.themeMode!;
        await Application.pref
            .setString(StorageKeys.themeMode.name, "${event.themeMode}");
      }
    }
    emit(ThemeUpdated());
  }
}
