import 'package:flutter/material.dart';

class BuildAlertDialog extends StatelessWidget {
  final Widget child;
  BuildAlertDialog({this.child});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 15),
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Builder(
        builder: (context) => Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: child,
        ),
      ),
    );
  }
}
