import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/modules/reservation/cubits/reservation_cubit.dart';
import 'package:trim/modules/reservation/cubits/reservation_states.dart';
import 'package:trim/general_widgets/price_information.dart';
import 'package:trim/modules/reservation/models/order_model.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/app_dialog.dart';
import 'package:trim/general_widgets/BuildAppBar.dart';
import 'package:trim/modules/reservation/widgets/BuildCardWidget.dart';
import 'package:trim/modules/reservation/widgets/reservation_item.dart';
import 'package:trim/general_widgets/default_button.dart';

class ReservationDetailsScreen extends StatelessWidget {
  static final String routeName = 'reservationDetailsScreen';

  @override
  Widget build(BuildContext context) {
    OrderModel reservationData =
        ModalRoute.of(context).settings.arguments as OrderModel;
    return Scaffold(
      body: SafeArea(child: InfoWidget(
        responsiveWidget: (context, deviceInfo) {
          double fontSize = getFontSizeVersion2(deviceInfo);
          return BlocConsumer<ReservationCubit, ReservationStates>(
            listener: (_, state) {
              if (state is LoadedCancedReservationState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'The reservaion number ${reservationData.id} cancelled successifully')));
                Navigator.pop(context);
              }
            },
            builder: (_, state) {
              if (state is LoadingCancelReservationState)
                return Center(child: CircularProgressIndicator());

              return Column(
                children: [
                  buildAppBar(
                      localHeight: deviceInfo.localHeight,
                      fontSize: fontSize,
                      screenName: getWord('Reservation details', context)),
                  Expanded(
                    child: SingleChildScrollView(
                      child: TrimCard(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReservationItem(
                                reservation: reservationData,
                                fontSize: fontSize,
                                showMoreDetails: false),
                            Divider(
                              height: 2,
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            if (reservationData.statusId != "2")
                              PriceInformation(
                                total: reservationData.cost ?? "0",
                                discount: reservationData.discount ?? "0",
                                totalAfterDiscount:
                                    reservationData.total ?? "0",
                              ),
                            if (reservationData.statusId != "2")
                              buildReservationActions(fontSize, context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      )),
    );
  }

  Row buildReservationActions(double fontSize, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultButton(
            text: getWord('Modify order', context),
            onPressed: () {},
          ),
        )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DefaultButton(
              text: getWord('Cancel order', context),
              color: Colors.black,
              onPressed: () async {
                await showReasonCancelled(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
