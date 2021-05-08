import 'package:trim/appLocale/appLocale.dart';

import 'package:flutter/material.dart';

String getWord(String key,BuildContext context) {
 return AppLocale.of(context).getTranslatedWord(key);
}
