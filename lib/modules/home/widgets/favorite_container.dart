import 'package:flutter/material.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class FavoriteContainer extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final bool isFavorite;

  const FavoriteContainer({Key key, this.deviceInfo, this.isFavorite})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
                deviceInfo.orientation == Orientation.portrait ? 30 : 35),
            bottomRight: Radius.circular(
                deviceInfo.orientation == Orientation.portrait ? 30 : 35)),
        child: buildFavoriteContainer(deviceInfo.localHeight));
  }

  Widget buildFavoriteContainer(double height) {
    final favoriteContainerHeight =
        height / (deviceInfo.orientation == Orientation.portrait ? 10.3 : 2.7);

    final availableWidth = deviceInfo.localWidth;

    return Container(
      height: favoriteContainerHeight,
      width: availableWidth * 0.09,
      alignment: Alignment.center,
      color: Color(0xffDDD8E1),
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: availableWidth * 0.06,
        icon: Icon(
            isFavorite != null && isFavorite
                ? Icons.favorite
                : Icons.favorite_border_outlined,
            color: Color(0xff4678A3)),
        onPressed: () {},
      ),
    );
  }
}
