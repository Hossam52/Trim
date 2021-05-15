//for Custom app dialogs

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_states.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/models/salon_detail_model.dart';
import 'package:trim/modules/home/screens/reserve_screen.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';
import 'package:trim/modules/home/widgets/trim_cached_image.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/general_widgets/cancel_reasons.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

import 'Core/BuilderWidget/InfoWidget.dart';

void personDetailsDialog(
    DeviceInfo deviceInfo, BuildContext context, Salon salon) async {
  Widget elevatedButton(
      {String text, VoidCallback onPressed, Color color = Colors.blue}) {
    return DefaultButton(
      text: text,
      onPressed: onPressed,
      color: color,
    );
  }

  SalonsCubit.getInstance(context).getSalonDetails(id: salon.id);
  await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: BlocBuilder<SalonsCubit, SalonStates>(
              builder: (_, state) {
                if (state is LoadingSalonDetailState ||
                    state is LoadingAvilableDatesState)
                  return Center(child: CircularProgressIndicator());
                salon = SalonsCubit.getInstance(context).salonDetail;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: TrimCachedImage(
                              src: salon.image,
                              width: 0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  salon.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize:
                                          getFontSizeVersion2(deviceInfo)),
                                ),
                                BuildStars(
                                    stars: salon.rate,
                                    width:
                                        MediaQuery.of(context).size.width / 2),
                                Text(
                                    '${salon.commentsCount} ${getWord('openions', context)}')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    elevatedButton(
                      text: getWord('Reserve now', context),
                      onPressed: () async {
                        // await SalonsCubit.getInstance(context)
                        //     .getSalonDetails(id: salon.id);
                        Navigator.pop(context);
                        Navigator.pushNamed(context, ReserveScreen.routeName,
                            arguments: SalonDetailModel(
                                showDateWidget: false,
                                showAvailableTimes: true,
                                showServiceWidget: true,
                                showOffersWidget: false));
                      },
                    ),
                    elevatedButton(
                      text: getWord('Reserve appointment', context),
                      onPressed: () async {
                        // await SalonsCubit.getInstance(context)
                        //     .getSalonDetails(id: salon.id);
                        print(SalonsCubit.getInstance(context)
                            .salonDetail
                            .salonServices);
                        Navigator.pop(context);
                        Navigator.pushNamed(context, ReserveScreen.routeName,
                            arguments: SalonDetailModel(
                                showDateWidget: true,
                                showAvailableTimes: true,
                                showServiceWidget: true,
                                showOffersWidget: true));
                      },
                      color: Colors.black,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      });
}

Future<bool> exitConfirmationDialog(
    BuildContext context, String alertMessage) async {
  return await showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text('Alert'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(getWord('Cancel', context))),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text(getWord('Yes', context),
                      style: TextStyle(color: Colors.red))),
            ],
            content: Text(alertMessage),
            contentTextStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 15,
                color: Colors.black),
            contentPadding: const EdgeInsets.all(15),
          ));
}

Future<void> showReasonCancelled(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return InfoWidget(
          responsiveWidget: (context, deviceInfo) => Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                          height: deviceInfo.orientation == Orientation.portrait
                              ? deviceInfo.type == deviceType.mobile
                                  ? 45
                                  : 80
                              : deviceInfo.type == deviceType.mobile
                                  ? 80
                                  : 95),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          child: CancelReasons(deviceInfo),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    heightFactor: 1,
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: MediaQuery.of(context).size.width /
                          (deviceInfo.orientation == Orientation.portrait
                              ? 5
                              : 6),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
