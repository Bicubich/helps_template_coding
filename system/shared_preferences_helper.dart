import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _sharedPreferences;

  static Future<void> init() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  static Future setString(String key, String value) async {
    await _sharedPreferences!.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    return await _sharedPreferences!.getString(key);
  }

  static Future setBool(String key, bool value) async {
    await _sharedPreferences!.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    return await _sharedPreferences?.getBool(key) ?? false;
  }

  static Future remove(String key) async {
    return await _sharedPreferences!.remove(key);
  }
}
