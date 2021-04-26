
import 'package:flutter/material.dart';

class BuildListTileCofirm extends StatelessWidget {
  final String leading;
  final String trailing;
  final double fontSize;
  BuildListTileCofirm({this.leading, this.trailing, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        leading,
        style: TextStyle(fontSize: fontSize - 3),
      ),
      trailing: Text(
        trailing,
        style: TextStyle(fontSize: fontSize - 3, color: Colors.lightBlueAccent),
      ),
    );
  }
}