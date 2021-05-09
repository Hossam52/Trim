import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';

class SocialAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(icon: Image.asset(facebookImagePath), onPressed: () {}),
        IconButton(icon: Image.asset(googleImagePath), onPressed: () {}),
      ],
    );
  }
}
