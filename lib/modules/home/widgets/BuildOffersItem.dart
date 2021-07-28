import 'package:flutter/material.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/home/cubit/home_cubit.dart';
import 'package:trim/modules/home/models/salon_offer.dart';
import 'package:trim/general_widgets/trim_cached_image.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';

class BuildOffersItem extends StatelessWidget {
  final int offerIndex;

  const BuildOffersItem({Key key, @required this.offerIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SalonOffer lastOfferItem =
        HomeCubit.getInstance(context).getlastOfferItem(offerIndex);
    return ResponsiveWidget(
      responsiveWidget: (_, deviceInfo) => Stack(children: [
        TrimCachedImage(src: lastOfferItem.image),
        Positioned(
            bottom: 30,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                    lastOfferItem.descriptionAr ??
                        lastOfferItem.descriptionEn ??
                        "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: defaultFontSize(deviceInfo) * 0.75,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                decoration: BoxDecoration(
                  color: Color(0xff676363).withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ))),
      ]),
    );
  }
}
