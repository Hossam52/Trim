import 'package:flutter/material.dart';

class TrimLoadingWidget extends StatelessWidget {
  const TrimLoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
      Theme.of(context).accentColor,
    )));
  }
}
