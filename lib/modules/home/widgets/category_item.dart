import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/models/Category.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key key,
    @required this.category,
    @required this.deviceInfo,
  }) : super(key: key);

  final Category category;
  final DeviceInfo deviceInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: buildCategoryImage(),
        ),
        Expanded(
          child: buildCategoryName(),
        ),
      ],
    );
  }

  Text buildCategoryName() {
    return Text(
      category.name,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: deviceInfo.type == deviceType.mobile &&
                  deviceInfo.screenWidth >= 530
              ? getFontSize(deviceInfo) + 4
              : getFontSize(deviceInfo)),
    );
  }

  CircleAvatar buildCategoryImage() {
    double calculateRadius() {
      bool isPortrait = deviceInfo.orientation == Orientation.portrait;
      if (deviceInfo.type == deviceType.mobile) {
        if (isPortrait)
          return 50;
        else
          return 55;
      } else {
        if (isPortrait)
          return 55;
        else
          return 60;
      }
      // deviceInfo.type == deviceType.mobile
      //     ? deviceInfo.orientation == Orientation.portrait
      //         ? 50
      //         : 55
      //     : deviceInfo.orientation == Orientation.portrait
      //         ? 55
      //         : 65;
    }

    return CircleAvatar(
      child: Image.asset(
        'assets/icons/${category.imageName}.png',
        fit: BoxFit.cover,
      ),
      radius: calculateRadius(),
      backgroundColor: Colors.cyanAccent[100],
    );
  }
}
