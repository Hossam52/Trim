import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:trim/modules/home/models/barber.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';
import 'package:trim/utils/ui/app_dialog.dart';

class BuildStarPersonItem extends StatelessWidget {
  final Barber barber;

  const BuildStarPersonItem({Key key, @required this.barber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        personDetailsDialog(context, barber);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 7),
        width: MediaQuery.of(context).size.width / 3.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.asset(
                barber.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  barber.name,
                  style: TextStyle(
                    fontSize: ResponsiveFlutter.of(context).fontSize(2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Container(
                  height: ResponsiveFlutter.of(context).scale(17),
                  child: BuildStars(
                      width: MediaQuery.of(context).size.width / 2,
                      stars: barber.stars),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}