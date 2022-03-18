import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences? prefs;

  static Future<SharedPreferences> getSharedPreferences() async {
    if (prefs == null) {
      return await SharedPreferences.getInstance();
    } else {
      return prefs ?? await SharedPreferences.getInstance();
    }
  }

  static Future<String> getString(String key, String defaultValue) async {
    SharedPreferences prefs = await getSharedPreferences();
    return prefs.getString(key) ?? defaultValue;
  }

  static Future<int> getInt(String key, int def) async {
    SharedPreferences prefs = await getSharedPreferences();
    return prefs.getInt(key) ?? def;
  }

  static Future<bool> getBoolean(String key, bool def) async {
    SharedPreferences prefs = await getSharedPreferences();
    return prefs.getBool(key) ?? def;
  }

  static putBoolean(String key, bool value) async {
    SharedPreferences prefs = await getSharedPreferences();
    prefs.setBool(key, value);
  }

  static putString(String key, String value) async {
    SharedPreferences prefs = await getSharedPreferences();
    prefs.setString(key, value);
  }

  static putInt(String key, int value) async {
    SharedPreferences prefs = await getSharedPreferences();
    prefs.setInt(key, value);
  }
}
