import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesServices {
  static SharedPreferences? prefs;
  static setEmail({required String email}) {
    prefs?.setString('email', email);
  }

  static setName({required String name}) {
    prefs?.setString('name', name);
  }

  static setPassword({required String password}) {
    prefs?.setString('password', password);
  }

  static String getEmail() {
    return prefs?.getString("email") ?? "";
  }

  static String getName() {
    return prefs?.getString("name") ?? "";
  }

  static String getPassword() {
    return prefs?.getString("password") ?? "";
  }

  static removePrefs() {
    prefs?.remove("name");
    prefs?.remove("email");
    prefs?.remove("password");
  }

  static setPrefs(
      {required String email, required String password, String? name}) {
    setName(name: name ?? "User");
    setEmail(email: email);
    setPassword(password: password);
  }
}
