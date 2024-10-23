import 'package:shared_preferences/shared_preferences.dart';

class SettingManager {
  SharedPreferences? localStorage;

  //Reciter
  Future<void> saveReciterName(String name) async {
    localStorage = await SharedPreferences.getInstance();
    localStorage?.setString("name", name);
  }

  Future<String> getReciterName() async {
    localStorage = await SharedPreferences.getInstance();
    return localStorage?.getString("name") ?? "Abdul Samad";
  }

  //Translation language
  Future<void> saveTranslationName(String name) async {
    localStorage = await SharedPreferences.getInstance();
    localStorage?.setString("translation", name);
  }

  Future<String> getTranslationName() async {
    localStorage = await SharedPreferences.getInstance();
    return localStorage?.getString("translation") ?? "Urdu";
  }
}
