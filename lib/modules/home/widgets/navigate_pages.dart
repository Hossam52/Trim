import 'package:flutter/material.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/constants/colors.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class NavigatePages extends StatelessWidget {
  final Function(BuildContext) nextPage;
  final Function(BuildContext) prevPage;
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
      child: InfoWidget(
        responsiveWidget: (_, deviceInfo) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navigationButton(
                getWord('Previous', context), () => prevPage(context)),
            Text('$pageNumber',
                style: TextStyle(
                    fontSize: getFontSizeVersion2(deviceInfo),
                    fontWeight: FontWeight.bold)),
            navigationButton(getWord('Next', context), () => nextPage(context)),
          ],
        ),
      ),
    );
  }

  Widget navigationButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(text),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          foregroundColor: MaterialStateProperty.all(Colors.white)),
    );
  }
}
