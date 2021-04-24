import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:trim/modules/home/screens/BadgeScreen.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Badge(
        showBadge: true,
        badgeContent: Text('2'),
        child: IconButton(
          iconSize: width / 9,
          icon: Icon(
            Icons.shopping_cart_outlined,
          ),
          onPressed: () {
            Navigator.pushNamed(context, BadgeScrren.routeName);
          },
          padding: const EdgeInsets.all(0),
        ));
  }
}
