import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:pos/core/local_storage/setting_preferences.dart';

enum LanguageCode { id, en }

@singleton
class LanguageService extends ChangeNotifier {
  static Locale localeEN = Locale(LanguageCode.en.name);
  static Locale localeID = Locale(LanguageCode.id.name);

  final SettingPreferences preferences;

  LanguageService(this.preferences);

  Locale _current = localeID;

  Locale get currentLocale => _current;

  Future<void> initLocale() async {
    String? savedLocale = await preferences.getLocale();

    if (savedLocale == null) {
      _current = localeID;
      notifyListeners();

      await preferences.setLocale(LanguageCode.id.name);
      return;
    }

    if (savedLocale == LanguageCode.id.name) {
      await setLocale(LanguageCode.id);
    } else {
      await setLocale(LanguageCode.en);
    }
  }

  Future<void> setLocale(LanguageCode languageCode) async {
    if (languageCode == LanguageCode.id) {
      _current = localeID;
    } else {
      _current = localeEN;
    }
    Intl.defaultLocale == languageCode.name;

    notifyListeners();
    await preferences.setLocale(languageCode.name);
  }
}
