import 'package:flutter/material.dart';

class TrimAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.grey[200].withAlpha(150),
        child: Align(
          alignment: Alignment.centerLeft,
          heightFactor: 1,
          child: BackButton(color: Colors.black),
        ));
  }
}
