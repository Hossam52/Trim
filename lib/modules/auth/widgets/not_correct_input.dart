import 'package:flutter/material.dart';
import '../../../constants/app_constant.dart';

class ErrorWarning extends StatelessWidget {
  final String text;

  const ErrorWarning({Key key, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.blue.withAlpha(155),
        width: constraints.maxWidth,
        //height: 50,
        child: Center(
            child: Text(text,
                style:
                    TextStyle(fontSize: defaultFontSize, color: Colors.white))),
      );
    });
  }
}
