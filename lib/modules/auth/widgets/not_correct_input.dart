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
    return LayoutBuilder(builder: (context, constraints) {
      return InfoWidget(
        responsiveWidget: (_, deviceInfo) => Container(
          padding: const EdgeInsets.all(10.0),
          width: constraints.maxWidth,
          decoration: BoxDecoration(
              color: Colors.red.withAlpha(155),
              borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: Row(
            children: [
              Flexible(
                child: Center(
                  child: Text(text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: getFontSizeVersion2(deviceInfo),
                          color: Colors.white)),
                ),
              ),
              if (widget != null) Expanded(child: widget),
            ],
          )),
        ),
      );
    });
  }
}
