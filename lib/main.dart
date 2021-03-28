import 'package:flutter/material.dart';

import './modules/auth/screens/registration_screen.dart';
import './constants/app_constant.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: TextTheme(button: TextStyle(fontSize: defaultFontSize))),
      // home: SplashScreen(alpha: 100, color: Color(0xff2B73A8)),
      home: RegistrationScreen(),
    );
  }
}
