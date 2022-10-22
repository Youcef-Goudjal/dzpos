import 'package:flutter_device_identifier/flutter_device_identifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Application {
  static bool debug = true;
  static late SharedPreferences pref;
  late String? imei;

  Future<void> setPreferences() async {
    pref = await SharedPreferences.getInstance();
    bool permission = await FlutterDeviceIdentifier.checkPermission();
    if (!permission) {
      permission = await FlutterDeviceIdentifier.requestPermission();
    }

    if (permission) {
      imei = await FlutterDeviceIdentifier.imeiCode;
    }
  }

  /// Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
