import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/screens/details_screen.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
              // child: Image.asset(
              //   mostSearchSalons[index].image,
              //   fit: BoxFit.fill,
              // ),
              child: buildCachedNetworkImage(mostSearcedList[index].image),
              // child: Image.network(
              //   mostSearcedList[index].image,
              //   loadingBuilder: (_, ch, event) =>
              //       Center(child: CircularProgressIndicator()),
              //   errorBuilder: (_, error, stackTrace) {
              //     return Center(
              //       child: Text('Not Found'),
              //     );
              //   },
              // ),
            ),
          ),
          // itemCount: mostSearchSalons.length < 6 ? mostSearchSalons.length : 6,
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

  Widget buildCachedNetworkImage(String src) {
    try {
      return Container(
          child: CachedNetworkImage(
        imageUrl: src,
        errorWidget: (_, error, temp) {
          print(error.runtimeType);
          return Center(
            child: Image.asset('assets/images/1.jpg'),
          );
        },
        progressIndicatorBuilder: (_, child, temp) => Center(
          child: CircularProgressIndicator(),
        ),
      ));
    } catch (erro) {
      return Icon(Icons.error);
    }
  }
}
