import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/widgets/date_builder.dart';

class SelectDateSliver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Select a suitable date',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
      leading: BackButton(
        color: Colors.black,
      ),
      flexibleSpace: DateBuilder(),
      floating: false,
      pinned: false,
      backgroundColor: Color(0xff2C73A8),
      expandedHeight: 230,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(roundedRadius),
              bottomRight: Radius.circular(roundedRadius))),
    );
  }
}
