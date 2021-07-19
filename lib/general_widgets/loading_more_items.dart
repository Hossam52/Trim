import 'package:flutter/material.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/general_widgets/trim_loading_widget.dart';

class LoadingMoreItemsIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TrimLoadingWidget(),
          SizedBox(width: 10),
          Container(
            child: Text(getWord('Loading', context) + '.....'),
          ),
        ],
      ),
    );
  }
}
