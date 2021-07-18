import 'package:flutter/material.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import '../../../constants/app_constant.dart';

class ErrorWarning extends StatelessWidget {
  final String text;
  final Widget widget;

  const ErrorWarning({Key key, @required this.text, this.widget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (_, deviceInfo) => Container(
        padding: const EdgeInsets.all(7.0),
        decoration: BoxDecoration(
            color: Colors.red.withAlpha(155),
            borderRadius: BorderRadius.circular(50)),
        child: Center(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Center(
                child: Text(text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: getFontSizeVersion2(deviceInfo) * 0.8,
                        color: Colors.white)),
              ),
            ),
            if (widget != null) Expanded(child: widget),
          ],
        )),
      ),
    );
  }
}
