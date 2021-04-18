import 'package:flutter/material.dart';

List<Widget> buildItemRowTable({String key, String value, double fontSize}) {
  return [
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        key,
        style: TextStyle(fontSize: fontSize),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        value,
        style: TextStyle(fontSize: fontSize),
      ),
    ),
  ];
}
