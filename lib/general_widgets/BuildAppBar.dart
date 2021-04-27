import 'package:flutter/material.dart';

import 'BuildBackButtonWidget.dart';

Widget buildAppBar({double localHeight, double fontSize, String screenName}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      BuildBackButtonWidget(
        localHeight: localHeight,
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Text(
          screenName,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    ],
  );
}
