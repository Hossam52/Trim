import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/models/trim_star_model.dart';
import 'package:trim/modules/home/screens/details_screen.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';
import 'package:trim/modules/home/widgets/favorite_container.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/modules/home/widgets/trim_cached_image.dart';

class BarberItem extends StatelessWidget {
  final bool showFavoriteContainer;
  final Salon personItem;

  final DeviceInfo deviceInfo;

  const BarberItem(
      {Key key,
      @required this.deviceInfo,
      @required this.personItem,
      this.showFavoriteContainer = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => SalonsCubit.getInstance(context)
              .navigateToSalonDetailScreen(context, personItem.id),
          child: GridTile(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: TrimCachedImage(src: personItem.image),
            ),
            footer: Container(
              color: Colors.grey[200].withAlpha(155),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    personItem.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: getFontSizeVersion2(deviceInfo),
                        fontWeight: FontWeight.bold),
                  ),
                  BuildStars(
                      stars: personItem.rate,
                      width: deviceInfo.localWidth / 1.8)
                ],
              ),
            ),
          ),
        ),
        if (showFavoriteContainer)
          Positioned(
            left: deviceInfo.localWidth *
                (deviceInfo.orientation == Orientation.portrait ? 0.08 : 0.06),
            child: FavoriteContainer(
              salonId: personItem.id,
              isFavorite: personItem.isFavorite,
              deviceInfo: deviceInfo,
            ),
          )
      ],
    );
  }
}
