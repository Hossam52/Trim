import 'package:trim/appLocale/appLocale.dart';

import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:trim/basic_data_model.dart';

String translatedWord(String key, BuildContext context) {
  return AppLocale.of(context).getTranslatedWord(key) ?? "N/A";
}

bool isArabic = (Platform.localeName.split('_')[0]) == 'ar';

String getTranslatedName(BasicData model) {
  if (isArabic) {
    if (model.nameAr != null)
      return model.nameAr;
    else if (model.nameEn != null)
      return model.nameEn;
    else
      return "";
  } else {
    if (model.nameEn != null)
      return model.nameEn;
    else if (model.nameAr != null)
      return model.nameAr;
    else
      return "";
  }
}
