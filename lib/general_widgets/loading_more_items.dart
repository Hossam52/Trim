import 'package:flutter/material.dart';

class LoadingMoreItemsIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Text('Loading...'),
          ),
        ],
      ),
    );
  }
}
