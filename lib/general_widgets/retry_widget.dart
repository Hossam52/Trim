import 'package:flutter/material.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';

class RetryWidget extends StatelessWidget {
  final String text;
  final VoidCallback onRetry;

  const RetryWidget({Key key, @required this.text, @required this.onRetry})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      responsiveWidget: (_, deviceInfo) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                text,
                style: TextStyle(fontSize: defaultFontSize(deviceInfo)),
              ),
            ),
            TextButton(
              child: Text(translatedWord('Retry now', context)),
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
