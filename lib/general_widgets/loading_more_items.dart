import 'package:flutter/material.dart';
import 'package:trim/appLocale/getWord.dart';

class LoadingMoreItemsIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 10),
          Container(
            child: Text(getWord('Loading', context) + '.....'),
          ),
        ],
      ),
    );
  }
}
