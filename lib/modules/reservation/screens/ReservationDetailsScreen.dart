import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/general_widgets/trim_loading_widget.dart';
import 'package:trim/modules/reservation/cubits/reservation_cubit.dart';
import 'package:trim/modules/reservation/cubits/reservation_states.dart';
import 'package:trim/general_widgets/price_information.dart';
import 'package:trim/modules/reservation/models/order_model.dart';
import 'package:trim/modules/reservation/screens/modify_salon_order.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/responsive_widget.dart';
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
      body: SafeArea(child: ResponsiveWidget(
        responsiveWidget: (context, deviceInfo) {
          double fontSize = defaultFontSize(deviceInfo);
          return BlocConsumer<ReservationCubit, ReservationStates>(
            listener: (_, state) {
              if (state is LoadedCancedReservationState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(translatedWord(
                            'The reservaion number', context) +
                        ' ' +
                        reservationData.id.toString() +
                        ' ' +
                        translatedWord('cancelled successifully', context))));
                Navigator.pop(context);
              }
            },
            builder: (_, state) {
              if (state is LoadingCancelReservationState)
                return TrimLoadingWidget();

              return Column(
                children: [
                  buildAppBar(
                      localHeight: deviceInfo.localHeight,
                      fontSize: fontSize,
                      screenName:
                          translatedWord('Reservation details', context)),
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
                              buildReservationActions(
                                  reservationData, fontSize, context),
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

  Widget buildReservationActions(
      OrderModel order, double fontSize, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (order.type.toLowerCase() != 'products')
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DefaultButton(
              text: translatedWord('Modify order', context),
              onPressed: () async {
                if (order.services.isNotEmpty) {
                  final succssModified = await Navigator.of(context)
                      .pushNamed(ModifySalonOrder.routeName, arguments: order);
                  if (succssModified != null && succssModified) {
                    ReservationCubit.getInstance(context)
                        .loadMyOrders(refreshPage: true);
                    Navigator.pop(context);
                  }
                }
              },
            ),
          )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DefaultButton(
              text: translatedWord('Cancel order', context),
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
