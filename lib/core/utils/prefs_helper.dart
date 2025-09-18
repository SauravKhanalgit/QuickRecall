import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static const _consentKey = 'userConsent';

  /// Get saved consent (default false)
  static Future<bool> getConsent() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_consentKey) ?? false;
  }

  /// Save consent
  static Future<void> setConsent(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_consentKey, value);
  }
}
