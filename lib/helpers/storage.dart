import 'package:queen/queen.dart';

// ignore: avoid_classes_with_only_static_members
abstract class AppStorage {
  static late SharedPreferences _prefs;
  static Future<void> boot() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getString(String key) => _prefs.getString(key) ?? '';

  static int getInt(String key) => _prefs.getInt(key) ?? -1;
  static bool getBool(String key) => _prefs.getBool(key) ?? false;

  static Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);
  static Future<void> setInt(String key, int value) =>
      _prefs.setInt(key, value);
  // ignore: avoid_positional_boolean_parameters
  static Future<void> setBool(String key, bool value) =>
      _prefs.setBool(key, value);
  static Future<void> clear() => _prefs.clear();
}
