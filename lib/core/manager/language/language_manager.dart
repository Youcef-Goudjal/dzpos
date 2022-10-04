import 'package:flutter/material.dart';

import '../../../product/constants/asset_constants.dart';

class LanguageManager {
  static final LanguageManager _instance = LanguageManager._init();
  static LanguageManager get instance => _instance;

  late Locale defaultLanguage = ar;

  LanguageManager._init();

  final en = const Locale("en");
  final ar = const Locale("ar");
  final fr = const Locale("fr");

  final path = AppAssets.translations;

  List<Locale> get supportedLocales => [en, fr, ar];
}
