import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class SalonLogo extends StatefulWidget {
  final double height;
  final String imagePath;
  final bool isFavorite;
  final DeviceInfo deviceInfo;
  const SalonLogo(
      {Key key,
      @required this.height,
      @required this.imagePath,
      @required this.isFavorite,
      @required this.deviceInfo})
      : super(key: key);

  @override
  _SalonLogoState createState() => _SalonLogoState();
}

class _SalonLogoState extends State<SalonLogo> {
  bool isPortrait;
  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    //final screenHeight = MediaQuery.of(context).size.height;
    isPortrait =
        widget.deviceInfo.orientation == Orientation.portrait ? true : false;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: widget.height,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Image.asset(
              widget.imagePath,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Positioned(
              left: widget.deviceInfo.localWidth * (isPortrait ? 0.08 : 0.06),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(isPortrait ? 30 : 35),
                      bottomRight: Radius.circular(isPortrait ? 30 : 35)),
                  child: buildFavoriteContainer(widget.deviceInfo.screenWidth,
                      widget.deviceInfo.screenHeight)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFavoriteContainer(double screenWidth, double screenHeight) {
    final favoriteContainerHeight = widget.height / (isPortrait ? 3.3 : 2.7);
    // final favoriteContainerWidth = screenWidth * 0.13;

    final availableWidth = widget.deviceInfo.localWidth;

    return Container(
      height: favoriteContainerHeight,
      width: availableWidth * 0.09,
      alignment: Alignment.center,
      color: Color(0xffDDD8E1),
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: availableWidth * 0.06,
        icon: Icon(
            widget.isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
            color: Color(0xff4678A3)),
        onPressed: () {},
      ),
    );
  }
}
