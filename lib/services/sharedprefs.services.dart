import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesServices {
  static SharedPreferences? prefs;
  static setLocale({required String locale}) async {
    await SharedPreferencesServices.prefs?.setString('locale', locale);
  }

  static String getLocale() {
    return SharedPreferencesServices.prefs?.getString("locale") ?? "";
  }
}
