import 'package:flutter/material.dart';
import '../../../constants/app_constant.dart';

class SplashScreen extends StatelessWidget {
  final int alpha;
  final Color color;
  SplashScreen({this.alpha = 0, this.color});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: width,
          height: height,
          child: Image.asset(
            Splash.splashBacground,
            fit: BoxFit.fill,
          ),
        ),
        Container(width: width, height: height, color: Splash.splashColor),
        Center(
            child: Container(
                width: height / 5,
                height: height / 5,
                child:
                    Image.asset("assets/images/logo.png", fit: BoxFit.fill))),
      ],
    ));
  }
}
