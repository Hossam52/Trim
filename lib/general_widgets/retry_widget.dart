import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class RetryWidget extends StatelessWidget {
  final String text;
  final VoidCallback onRetry;

  const RetryWidget({Key key, @required this.text, @required this.onRetry})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (_, deviceInfo) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                text,
                style: TextStyle(fontSize: getFontSizeVersion2(deviceInfo)),
              ),
            ),
            TextButton(
              child: Text('Retry now'),
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
