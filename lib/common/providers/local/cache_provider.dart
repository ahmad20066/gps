import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CacheProvider {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setAppToken(String token) async {
    await sharedPreferences!.setString("token", token);
  }

  static String getAppToken() {
    return sharedPreferences!.getString("token")!;
  }

  static String getDomain() {
    return sharedPreferences!.getString("domain")!;
  }

  static Future<void> clearAppToken() async {
    await sharedPreferences!.remove("token");
  }

  static Future<void> saveDomain(String domain) async {
    await sharedPreferences!.setString("domain", domain);
  }

  static Future<void> saveIsWorking(bool value) async {
    await sharedPreferences!.setBool("isWorking", value);
  }

  static bool getIsWorking() {
    return sharedPreferences!.getBool("isWorking")!;
  }

  static Future<void> cacheTasks(List<dynamic> tasks, String date) async {
    String tasksJson = json.encode(tasks);
    await sharedPreferences!.setString('cachedTasks', tasksJson);
    await sharedPreferences!.setString('cachedDate', date);
  }

  static List<dynamic>? getCachedTasks() {
    String? tasksJson = sharedPreferences!.getString('cachedTasks');
    if (tasksJson != null) {
      return json.decode(tasksJson);
    }
    return null;
  }

  static String? getCachedDate() {
    return sharedPreferences!.getString('cachedDate');
  }
}
