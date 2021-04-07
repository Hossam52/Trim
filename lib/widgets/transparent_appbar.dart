import 'package:flutter/material.dart';

class TransparentAppBar extends AppBar {
  final MaterialColor color;
  final String text;
  TransparentAppBar({this.color, this.text})
      : super(
          elevation: 0.0,
          backgroundColor: color == null ? Colors.transparent : color,
          title: text == null
              ? null
              : Text(text, style: TextStyle(color: Colors.black)),
          leading: BackButton(
            color: Colors.black,
          ),
        );
}
