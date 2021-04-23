//for Custom app dialogs

import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/constants/asset_path.dart';
import 'package:trim/modules/home/models/barber.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';

void personDetailsDialog(BuildContext context, Barber barber) {
  Widget elevatedButton(String text, [Color color = Colors.blue]) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              backgroundColor: MaterialStateProperty.all(color),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(roundedRadius))),
            ),
            onPressed: () {},
            child: FittedBox(child: Text(text))));
  }

  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.asset(barber.image)),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(barber.name),
                            BuildStars(
                                stars: barber.stars,
                                width: MediaQuery.of(context).size.width / 2),
                            Text('${barber.noOfRaters} Openion')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(),
                elevatedButton('Reserve now'),
                elevatedButton('Reserve appointment', Colors.black),
              ],
            ),
          ),
        );
      });
}

Future<bool> exitConfirmationDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text('Alert'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text('Yes', style: TextStyle(color: Colors.red))),
            ],
            content: Text('Are you sure to exit?'),
            contentTextStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 15,
                color: Colors.black),
            contentPadding: const EdgeInsets.all(15),
          ));
}
//salons dailog

