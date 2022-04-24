import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static late SharedPreferences sharedPreferences;

  static void init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveThemeMode({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences.setBool(key, value);
  }

  static Future<bool> saveCountry({
    required String key,
    required value,
  }) async {
    return await sharedPreferences.setString(key, value);
  }

  static String getCountry({
    required String key,
  }) {
    //if the string is null it will return eg
    return sharedPreferences.getString(key) ?? 'eg';
  }

  static bool getThemeMode({
    required String key,
  }) {
    //if the string is null it will return eg
    return sharedPreferences.getBool(key) ?? false;
  }
}
