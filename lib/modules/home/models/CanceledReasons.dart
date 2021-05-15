import 'package:flutter/material.dart';
import 'package:trim/appLocale/getWord.dart';

List<String> getCancelReasons(BuildContext context) => [
      getWord('Change My openion and request another salon', context),
      getWord('Services is not complete', context),
      getWord('Try The app', context),
      getWord('Wait too long', context),
      getWord('Salon is not arranged', context),
      getWord('Don\'t get copoun', context),
      getWord('Another reason', context)
    ];
