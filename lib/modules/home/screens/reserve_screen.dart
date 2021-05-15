import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_states.dart';
import 'package:trim/modules/home/models/salon_offer.dart';
import 'package:trim/modules/home/screens/Salons_Screen.dart';
import 'package:trim/modules/home/screens/details_screen.dart';
import 'package:trim/modules/home/screens/home_Screen.dart';
import 'package:trim/modules/home/widgets/available_times.dart';
import 'package:trim/general_widgets/price_information.dart';
import 'package:trim/modules/home/widgets/salon_offers.dart';
import 'package:trim/modules/home/widgets/salon_services.dart';
import 'package:trim/modules/home/widgets/select_date_sliver.dart';
import 'package:trim/modules/payment/cubits/payment_cubit.dart';
import 'package:trim/modules/payment/screens/payment_methods_screen.dart';
import 'package:trim/modules/reservation/screens/ReservationDetailsScreen.dart';
import 'package:trim/modules/reservation/screens/ReservationsScreen.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/modules/home/models/salon_detail_model.dart';

class ReserveScreen extends StatelessWidget {
  static const routeName = '/reserve-screen';

  @override
  Widget build(BuildContext context) {
    SalonDetailModel model =
        ModalRoute.of(context).settings.arguments as SalonDetailModel;
    final selectDateWidget = model.showDateWidget;
    final availableDatesWidget = model.showAvailableTimes;
    final servicesWidget = model.showServiceWidget;
    final offersWidget = model.showOffersWidget;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: InfoWidget(
          responsiveWidget: (context, deviceInfo) => SafeArea(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                if (selectDateWidget != false) SelectDateSliver(),
                SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    if (selectDateWidget == false)
                      Align(
                          alignment: Alignment.centerLeft, child: BackButton()),
                    if (availableDatesWidget != false) AvailableTimes(),
                    if (selectDateWidget != false ||
                        availableDatesWidget != false)
                      Divider(),
                    if (servicesWidget != false) buildServices(context),
                    if (offersWidget != false) buildOffers(deviceInfo, context),
                    BlocBuilder<SalonsCubit, SalonStates>(
                      builder: (_, state) => PriceInformation(
                        total: SalonsCubit.getInstance(context)
                            .totalPrice
                            .toString(),
                        discount: '0',
                        totalAfterDiscount: SalonsCubit.getInstance(context)
                            .totalPrice
                            .toString(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: BlocBuilder<SalonsCubit, SalonStates>(
                        builder: (_, state) {
                          final canReserveSalon =
                              SalonsCubit.getInstance(context)
                                  .canReserveSalon();
                          return DefaultButton(
                              text: getWord('Reserve now', context),
                              widget: state is LoadingMakeOrderState
                                  ? Center(child: CircularProgressIndicator())
                                  : null,
                              onPressed: !canReserveSalon ||
                                      state is LoadingMakeOrderState
                                  ? null
                                  : reserveSalonFunction(context));
                        },
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  VoidCallback reserveSalonFunction(BuildContext context) {
    return () async {
      await Navigator.pushNamed(context, PaymentMethodsScreen.routeName,
          arguments: {
            'totalPrice': SalonsCubit.getInstance(context).totalPrice
          });

      if (PaymentCubit.getInstance(context).successPayment) {
        await SalonsCubit.getInstance(context).orderSalonWithServices(context);
        await Navigator.pushNamed(context, ReservationsScreen.routeName);
        int counter = 0;
        Navigator.popUntil(context, (route) => counter++ == 2);
      }
    };
  }

  Widget buildOffers(DeviceInfo deviceInfo, BuildContext context) {
    List<SalonOffer> salonOffers =
        SalonsCubit.getInstance(context).salonDetail.salonOffers;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SalonOffers(deviceInfo, salonOffers),
    );
  }

  Widget buildServices(BuildContext context) {
    return InfoWidget(
      responsiveWidget: (_, deviceInfo) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SalonsCubit, SalonStates>(
          buildWhen: (old, newState) => newState is ToggleSelectedServiceState,
          builder: (_, state) => SalonServices(
            deviceInfo: deviceInfo,
            services:
                SalonsCubit.getInstance(context).salonDetail.salonServices,
          ),
        ),
      ),
    );
  }
}
