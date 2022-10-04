import 'package:shared_preferences/shared_preferences.dart';

class Application {
  static bool debug = true;
  static late SharedPreferences pref;

  Future<void> setPreferences() async {
    pref = await SharedPreferences.getInstance();
  }

  /// Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
