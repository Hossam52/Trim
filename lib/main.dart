import 'package:flutter/material.dart';

import './screens/home_Screen.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen());
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color.fromARGB(50, 20, 150, 200),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(1000)),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.green,
                child: Center(
                  child: Text(
                    'Trim',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 10),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
