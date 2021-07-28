import 'package:flutter/material.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/constants/colors.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';

class NavigatePages extends StatelessWidget {
  final void Function(BuildContext) nextPage;
  final void Function(BuildContext) prevPage;
  final int pageNumber;

  const NavigatePages(
      {Key key,
      @required this.nextPage,
      @required this.prevPage,
      @required this.pageNumber})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ResponsiveWidget(
        responsiveWidget: (_, deviceInfo) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: navigationButton(
                    Icons.navigate_before, () => prevPage(context))),
            Expanded(
              child: Center(
                child: Text('$pageNumber',
                    style: TextStyle(
                        fontSize: defaultFontSize(deviceInfo),
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Expanded(
                child: navigationButton(
                    Icons.navigate_next, () => nextPage(context))),
          ],
        ),
      ),
    );
  }

  Widget navigationButton(IconData icon, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(icon) //Text(text),
          ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          foregroundColor: MaterialStateProperty.all(Colors.white)),
    );
  }
}
