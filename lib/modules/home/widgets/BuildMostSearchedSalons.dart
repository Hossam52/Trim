import 'package:flutter/material.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/screens/salon_detail_screen.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class BuildMostSearchedSalons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (context, deviceInfo) {
        print(deviceInfo.localHeight);
        return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(2),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, SalonDetailScreen.routeName,
                  arguments: mostSearchSalons[index]);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                mostSearchSalons[index].imagePath,
                fit: BoxFit.fill,
              ),
            ),
          ),
          itemCount: mostSearchSalons.length < 6 ? mostSearchSalons.length : 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 4,
            childAspectRatio:
                (deviceInfo.localWidth / (deviceInfo.localHeight) / 1.5),
          ),
        );
      },
    );
  }
}
