import 'package:flutter/material.dart';

class BuildButtonView extends StatelessWidget {
  final void Function(BuildContext context) function;
  final String label;
  final textSize;
  BuildButtonView({this.function, this.label, this.textSize});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topRight,
        child: TextButton(
            onPressed: () => function(context),
            child: Text(
              label,
              style: TextStyle(fontSize: textSize),
            )));
  }
}
