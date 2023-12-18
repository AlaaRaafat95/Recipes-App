import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesServices {
  static SharedPreferences? prefs;
  static setEmail({required String email}) async {
    return await SharedPreferencesServices.prefs?.setString('email', email);
  }

  static setName({required String name}) async {
    await SharedPreferencesServices.prefs?.setString('name', name);
  }

  static setPassword({required String password}) async {
    await SharedPreferencesServices.prefs?.setString('password', password);
  }

  static String getEmail({required String email}) {
    return SharedPreferencesServices.prefs?.getString(email) ?? "";
  }

  static String getName({required String name}) {
    return SharedPreferencesServices.prefs?.getString(name) ?? "";
  }

  static String getPassword({required String password}) {
    return SharedPreferencesServices.prefs?.getString(password) ?? "";
  }

  static removePrefs() async {
    await SharedPreferencesServices.prefs?.remove("name");
    await SharedPreferencesServices.prefs?.remove("email");
    await SharedPreferencesServices.prefs?.remove("password");
  }

  static setPrefs(
      {required String email, required String password, String? name}) {
    setName(name: name ?? "User");
    setEmail(email: email);
    setPassword(password: password);
  }
}
