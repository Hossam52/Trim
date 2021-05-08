import 'package:flutter/material.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/screens/details_screen.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/modules/home/widgets/trim_cached_image.dart';

class BuildMostSearchedSalons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mostSearcedList = HomeCubit.getInstance(context).mostSearchList;
    
    return InfoWidget(
      responsiveWidget: (context, deviceInfo) {
        print(deviceInfo.localHeight);
        return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(2),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, DetailsScreen.routeName,
                  arguments: mostSearcedList[index]);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: TrimCachedImage(src: mostSearcedList[index].image),
            ),
          ),
          itemCount: mostSearcedList.length < 6 ? mostSearcedList.length : 6,
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
