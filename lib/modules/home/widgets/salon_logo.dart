import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';

class SalonLogo extends StatelessWidget {
  final double height;
  final String imagePath;
  final bool isFavorite;
  const SalonLogo(
      {Key key,
      @required this.height,
      @required this.imagePath,
      @required this.isFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: height,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Positioned(
              left: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: buildFavoriteContainer(screenWidth, screenHeight),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFavoriteContainer(double screenWidth, double screenHeight) {
    final favoriteContainerHeight = screenHeight * 0.12;
    final favoriteContainerWidth = screenWidth * 0.13;

    final favoriteIconSize = screenWidth * 0.1;

    return Container(
        height: favoriteContainerHeight,
        width: favoriteContainerWidth,
        alignment: Alignment.bottomCenter,
        color: Colors.grey,
        child: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                size: favoriteIconSize,
                color: Colors.blue[900]),
            onPressed: () {},
          ),
        ));
  }
}
