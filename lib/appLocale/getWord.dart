import 'package:trim/appLocale/appLocale.dart';

import 'package:flutter/material.dart';
import 'dart:io' show Platform;

String getWord(String key, BuildContext context) {
  return AppLocale.of(context).getTranslatedWord(key);
}

bool isArabic = (Platform.localeName.split('_')[0]) == 'ar';
