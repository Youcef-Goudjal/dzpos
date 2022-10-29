import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Application {
  static bool debug = true;
  static late SharedPreferences pref;
  late String? deviceId;

  Future<void> setPreferences() async {
 
      pref = await SharedPreferences.getInstance();
      
    
        deviceId = await PlatformDeviceId.getDeviceId;
   
  }

  /// Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
