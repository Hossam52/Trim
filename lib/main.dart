import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:trim/modules/auth/screens/verification_code_screen.dart';
import 'package:trim/modules/home/screens/home_screen.dart';
import 'package:trim/modules/home/screens/map_screen.dart';
import 'package:trim/utils/services/verification_code_service.dart';

import './modules/auth/screens/registration_screen.dart';
import './constants/app_constant.dart';
import './modules/auth/screens/login_screen.dart';
import './config/routes/routes_builder.dart';

main() => runApp(DevicePreview(builder: (_) => MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            textTheme: TextTheme(button: TextStyle(fontSize: defaultFontSize))),
        // home: SplashScreen(alpha: 100, color: Color(0xff2B73A8)),
        builder: DevicePreview.appBuilder,
        home: HomeScreen(),
        routes: routes);
  }
}
