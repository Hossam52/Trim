import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/widgets/BuildStarPersonItem.dart';

class BuildStarsPersonsWidget extends StatelessWidget {
  const BuildStarsPersonsWidget({
    @required this.heightNavigationBar,
  });

  final int heightNavigationBar;

  @override
  Widget build(BuildContext context) {
    final trimStarList = HomeCubit.getInstance(context).trimStarList;
    return Container(
      height: ResponsiveFlutter.of(context).scale(200) - heightNavigationBar,
      child: ListView.builder(
        itemCount: trimStarList.length + 1,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => index == trimStarList.length
            ? goToTrimStars(context)
            : BuildStarPersonItem(
                trimStarItem: trimStarList[index],
              ),
      ),
    );
  }

  Widget goToTrimStars(BuildContext context) {
    return Center(
        child: TextButton(
      child: Container(
        height: double.infinity,
        child: Row(
          children: [
            Text(getWord('More', context)),
            Icon(Icons.navigate_next_sharp)
          ],
        ),
      ),
      onPressed: () =>
          HomeCubit.getInstance(context).navigateToTrimStars(context),
    ));
  }
}
