import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/widgets/BuildOffersItem.dart';

class BuildOffersWidgetItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lastOffersLength =
        HomeCubit.getInstance(context).lastSalonOffersLength;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: ResponsiveFlutter.of(context).scale(2)),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: CarouselSlider.builder(
        options: CarouselOptions(
            autoPlay: true, enlargeCenterPage: true, aspectRatio: 2.9),
        itemCount: lastOffersLength,
        itemBuilder: (context, index, _) => BuildOffersItem(offerIndex: index),
      ),
    );
  }
}
