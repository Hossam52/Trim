import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/home/cubit/persons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_states.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class FavoriteContainer extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final bool isFavorite;
  final int salonId;

  const FavoriteContainer(
      {Key key, this.deviceInfo, this.isFavorite, @required this.salonId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
                deviceInfo.orientation == Orientation.portrait ? 30 : 35),
            bottomRight: Radius.circular(
                deviceInfo.orientation == Orientation.portrait ? 30 : 35)),
        child: buildFavoriteContainer(deviceInfo.localHeight, context));
  }

  Widget buildFavoriteContainer(double height, BuildContext context) {
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
        icon: BlocBuilder<SalonsCubit, SalonStates>(
          builder: (_, state) => Icon(
              isFavorite != null && isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
              color: Color(0xff4678A3)),
        ),
        onPressed: () {
          SalonsCubit.getInstance(context).addSalonToFavorite(
              salonId: salonId); //To send request to rest api
          PersonsCubit.getInstance(context)
              .loadFavoritePersons(refreshPage: true);
        },
      ),
    );
  }
}
