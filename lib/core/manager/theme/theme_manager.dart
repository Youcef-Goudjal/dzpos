import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static final ThemeManager _instance = ThemeManager._init();
  static ThemeManager get instance => _instance;

  late ThemeMode defaultThemeMode = ThemeMode.system;
  FlexScheme defaultFlexScheme = FlexScheme.aquaBlue;

  ThemeManager._init();

  ThemeData get darkTheme => FlexThemeData.dark(
        scheme: defaultFlexScheme,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        appBarOpacity: 0.90,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 30,
          cardRadius: 18.0,
          inputDecoratorRadius: 16,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        textTheme: GoogleFonts.cairoTextTheme(),
      );
  ThemeData get lightTheme => FlexThemeData.light(
        scheme: defaultFlexScheme,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 20,
        appBarOpacity: 0.95,
        subThemesData: const FlexSubThemesData(
            blendOnLevel: 20,
            blendOnColors: false,
            cardRadius: 18.0,
            elevatedButtonRadius: 15,
            textButtonRadius: 15,
            elevatedButtonElevation: 5,
            outlinedButtonRadius: 15,
            buttonPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        textTheme: GoogleFonts.cairoTextTheme(),
      );
}
