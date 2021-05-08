import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocale {
  Locale locale; //language ar,en,etc ..
  AppLocale(this.locale);
  Map<String, String> _translatedLanguage;
  static AppLocale of(BuildContext context) {
    return Localizations.of(context, AppLocale);
  }

  Future<void> loadLanguage() async {
    String _loadedFile = await rootBundle
        .loadString('assets/languages/${locale.languageCode}.json');
    Map<String, dynamic> loadedLanguage = jsonDecode(_loadedFile);
    _translatedLanguage =
        loadedLanguage.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslatedWord(String key) {
    return _translatedLanguage[key];
  }

  static const LocalizationsDelegate<AppLocale> delegate = _AppLocaleDelegate();
}

class _AppLocaleDelegate extends LocalizationsDelegate<AppLocale> {
  const _AppLocaleDelegate();
  @override
  bool isSupported(Locale locale) {
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocale> load(Locale locale) async {
    AppLocale appLocale = AppLocale(locale);
    await appLocale.loadLanguage();
    return appLocale;
  }

  @override
  bool shouldReload(_AppLocaleDelegate old) => false;
}
