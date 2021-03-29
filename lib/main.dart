import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import './modules/auth/screens/registration_screen.dart';
import './constants/app_constant.dart';
import './modules/auth/screens/login_screen.dart';
import './config/routes/routes_builder.dart';

main() => runApp(DevicePreview(builder: (_) => MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            textTheme: TextTheme(button: TextStyle(fontSize: defaultFontSize))),
        // home: SplashScreen(alpha: 100, color: Color(0xff2B73A8)),
        builder: DevicePreview.appBuilder,
        home: LoginScreen(),
        routes: routes);
  }
}
