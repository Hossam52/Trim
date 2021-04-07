import 'package:flutter/material.dart';

class BuildBackButtonWidget extends StatelessWidget {
  final double localHeight;
  BuildBackButtonWidget({this.localHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (localHeight / 11),
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
