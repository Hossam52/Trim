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
      padding: const EdgeInsets.only(right: 5, bottom: 5, top: 5),
      child: Text(
        value,
        style: TextStyle(fontSize: fontSize),
      ),
    ),
  ];
}
