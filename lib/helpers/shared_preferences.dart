import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/shared_preferences_constants.dart';

class SharedPreferencesHelper {
  static SharedPreferences? languagePreference;
  static Future<void> init() async {
    languagePreference = await SharedPreferences.getInstance();
  }

  static Future<String> getPreferedLangauge() async {
    return languagePreference
            ?.getString(SharedPreferencesConstants.preferedLanguageKey) ??
        "en";
  }

  static Future<void> setPreferedLangauge(String languageCode) async {
    await languagePreference?.setString(
        SharedPreferencesConstants.preferedLanguageKey, languageCode);
  }
}