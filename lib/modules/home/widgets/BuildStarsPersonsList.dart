import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:trim/modules/home/models/barber.dart';
import 'package:trim/modules/home/widgets/BuildStarPersonItem.dart';

class BuildStarsPersonsWidget extends StatelessWidget {
  const BuildStarsPersonsWidget({
    @required this.heightNavigationBar,
  });

  final int heightNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveFlutter.of(context).scale(200) - heightNavigationBar,
      child: ListView.builder(
        itemCount: barbers.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => BuildStarPersonItem(
          barber: barbers[index],
        ),
      ),
    );
  }
}