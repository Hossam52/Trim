import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/screens/details_screen.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';

class BuildSalonItemGrid extends StatelessWidget {
  final Salon salon;
  BuildSalonItemGrid({this.salon});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('pressed');
        Navigator.pushNamed(context, DetailsScreen.routeName, arguments: salon);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  salon.imagePath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FittedBox(
                      child: Container(
                        child: Text(
                          salon.salonName,
                          style: TextStyle(
                              color: Colors.cyan,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(1.9),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      height: ResponsiveFlutter.of(context).scale(14),
                      child: BuildStars(
                          stars: salon.salonRate,
                          width: MediaQuery.of(context).size.width / 2),
                    ),
                    Text(
                      salon.isOpen ? 'Open now' : 'Closed now',
                      style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(1.9),
                          color: salon.isOpen ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
