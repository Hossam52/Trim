import 'package:flutter/material.dart';

Widget buildCardWidget({Widget child}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 10,
      shadowColor: Colors.grey[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: child,
    ),
  );
}
