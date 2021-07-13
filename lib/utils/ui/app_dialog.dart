//for Custom app dialogs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/general_widgets/trim_text_field.dart';
import 'package:trim/modules/auth/cubits/auth_cubit.dart';
import 'package:trim/modules/auth/cubits/auth_states.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_states.dart';
import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/models/salon_detail_model.dart';
import 'package:trim/modules/home/screens/reserve_screen.dart';
import 'package:trim/modules/home/widgets/build_stars.dart';
import 'package:trim/modules/home/widgets/trim_cached_image.dart';
import 'package:trim/modules/payment/cubits/address_cubit.dart';
import 'package:trim/utils/ui/Core/Enums/DeviceType.dart';
import 'package:trim/general_widgets/cancel_reasons.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

import 'Core/BuilderWidget/InfoWidget.dart';

void personDetailsDialog(
    DeviceInfo deviceInfo, BuildContext context, Salon salon) async {
  Widget elevatedButton(
      {String text, VoidCallback onPressed, Color color = Colors.blue}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: DefaultButton(
        text: text,
        onPressed: onPressed,
        color: color,
      ),
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
                        print(
                            SalonsCubit.getInstance(context).salonDetail.name);
                        // await SalonsCubit.getInstance(context)
                        //     .getSalonDetails(id: salon.id);
                        Navigator.pop(context);
                        Navigator.pushNamed(context, ReserveScreen.routeName,
                            arguments: SalonDetailModel(
                                showCopounWidget: true,
                                showDateWidget: false,
                                showAvailableTimes: true,
                                showServiceWidget: true,
                                showOffersWidget: false));
                      },
                    ),
                    elevatedButton(
                      text: getWord('Reserve appointment', context),
                      onPressed: () async {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, ReserveScreen.routeName,
                            arguments: SalonDetailModel(
                                showCopounWidget: true,
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
            title: Text(getWord('Alert', context)),
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
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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

Future<bool> openLocationSetting(BuildContext context) async {
  bool res = false;

  await showDialog(
      context: context,
      builder: (_) => AlertDialog(
            content: Text(getWord(
                'Location settings is disabled Open settings?', context)),
            actions: [
              TextButton(
                  onPressed: () async {
                    await Geolocator.openLocationSettings();
                    res = await Geolocator.isLocationServiceEnabled();
                    Navigator.pop(context, true);
                  },
                  child: Text(getWord('OK', context))),
              TextButton(
                  onPressed: () {
                    res = false;
                    Navigator.pop(context, true);
                  },
                  child: Text(getWord('NO', context),
                      style: TextStyle(color: Colors.red))),
            ],
          ));
  return res;
}

Future<bool> confirmReservation(BuildContext context) async {
  return await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(getWord('Reserve this salon?', context)),
          content: Text(getWord(
              'You are about to reserve this salon are you sure to contiue?',
              context)),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop<bool>(context, true);
                },
                child: Text(getWord('Yes', context))),
            TextButton(
                onPressed: () {
                  Navigator.pop<bool>(context, false);
                },
                child: Text(getWord('NO', context),
                    style: TextStyle(color: Colors.red))),
          ],
        );
      });
}

Future<bool> confirmLogout(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(getWord('Warning', context)),
      content: Text(getWord('Are you sure to log out?', context)),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop<bool>(context, true);
            },
            child: Text(getWord('Yes', context))),
        TextButton(
            onPressed: () {
              Navigator.pop<bool>(context, false);
            },
            child: Text(getWord('NO', context),
                style: TextStyle(color: Colors.red))),
      ],
    ),
  );
}

Future<void> changeAddress(
    BuildContext context, GlobalKey<FormState> formKey) async {
  final cityController =
      TextEditingController(text: AddressCubit.getInstance(context).city);
  final streetController =
      TextEditingController(text: AddressCubit.getInstance(context).street);
  final countryController =
      TextEditingController(text: AddressCubit.getInstance(context).country);
  final phoneController =
      TextEditingController(text: AddressCubit.getInstance(context).phone);
  Scaffold.of(context).showBottomSheet(
      (_) => Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TrimTextField(
                    controller: cityController,
                    placeHolder: getWord('City', context),
                    validator: (address) {
                      if (address.isEmpty)
                        return getWord('Enter your address', context);
                      return null;
                    },
                  ),
                  TrimTextField(
                    controller: streetController,
                    placeHolder: getWord('Sreet', context),
                    validator: (address) {
                      if (address.isEmpty)
                        return getWord('Enter your address', context);
                      return null;
                    },
                  ),
                  TrimTextField(
                    controller: countryController,
                    placeHolder: getWord('Country', context),
                    validator: (address) {
                      if (address.isEmpty)
                        return getWord('Enter your address', context);
                      return null;
                    },
                  ),
                  TrimTextField(
                    controller: phoneController,
                    textInputType: TextInputType.phone,
                    placeHolder: getWord('Enter your phone', context),
                    validator: (phone) {
                      return AuthCubit.getInstance(context)
                          .validatePhone(phone, context);
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DefaultButton(
                          color: Colors.black,
                          text: getWord('Cancel', context),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: DefaultButton(
                          text: getWord('save', context),
                          onPressed: () async {
                            if (formKey.currentState.validate()) {
                              await AddressCubit.getInstance(context)
                                  .changeDeliveryData(
                                      enteredCity: cityController.text,
                                      enteredPhone: phoneController.text,
                                      enteredCountry: countryController.text,
                                      enteredStreet: streetController.text);
                              Navigator.pop(
                                context,
                              );
                            }
                          },
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
}

Future<void> loadingLogoutDialog(BuildContext context) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Dialog(
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (_, state) {
            if (state is LoadedLogoutState || state is ErrorLogoutState)
              Navigator.pop(context);
            if (state is LoadedLogoutState)
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(getWord('Logged out successifully', context))));
          },
          builder: (_, state) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<bool> confirmBack(BuildContext context) async {
  return await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
            content: Text(getWord(
                'You will lose current modifications are you sure to back ?',
                context)),
            actions: [
              TextButton(
                child: Text(getWord('Yes', context)),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              TextButton(
                child: Text(getWord('NO', context)),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              )
            ],
          ));
}
