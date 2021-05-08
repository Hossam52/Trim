import 'package:flutter/material.dart';
import '../../../constants/app_constant.dart';

class ErrorWarning extends StatelessWidget {
  final String text;
  final Widget widget;

  const ErrorWarning({Key key, @required this.text, this.widget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.blue.withAlpha(155),
        width: constraints.maxWidth,
        child: Center(
            child: Row(
          children: [
            Expanded(
              flex: 2,
              child: FittedBox(
                child: Text(text,
                    style: TextStyle(
                        fontSize: defaultFontSize, color: Colors.white)),
              ),
            ),
            if (widget != null) Expanded(child: widget),
          ],
        )),
      );
    });
  }
}
