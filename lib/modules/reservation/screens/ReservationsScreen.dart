import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/general_widgets/no_data_widget.dart';
import 'package:trim/general_widgets/trim_loading_widget.dart';
import 'package:trim/general_widgets/retry_widget.dart';
import 'package:trim/modules/reservation/cubits/reservation_cubit.dart';
import 'package:trim/modules/reservation/cubits/reservation_states.dart';
import 'package:trim/modules/reservation/models/order_model.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';
import 'package:trim/general_widgets/BuildAppBar.dart';
import 'package:trim/modules/reservation/widgets/BuildCardWidget.dart';
import 'package:trim/modules/reservation/widgets/reservation_item.dart';

import '../../../constants/app_constant.dart';

class ReservationsScreen extends StatefulWidget {
  static final String routeName = 'ReservationsScreen';

  @override
  _ReservationsScreenState createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  @override
  void initState() {
    super.initState();
    ReservationCubit.getInstance(context).loadMyOrders(refreshPage: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: InfoWidget(responsiveWidget: (context, deviceInfo) {
          double fontSize = getFontSizeVersion2(deviceInfo);
          return BlocBuilder<ReservationCubit, ReservationStates>(
            builder: (_, state) {
              if (state is LoadingReservationState) return TrimLoadingWidget();
              if (state is ErrorReservationState)
                return RetryWidget(
                    text: state.errorMessage,
                    onRetry: () => ReservationCubit.getInstance(context)
                        .loadMyOrders(refreshPage: true));
              final List<OrderModel> reservations =
                  ReservationCubit.getInstance(context).reservations;
              if (reservations.isEmpty) return EmptyDataWidget();
              return Column(
                children: [
                  buildAppBar(
                      localHeight: deviceInfo.localHeight,
                      fontSize: fontSize,
                      screenName: getWord('my reservations', context)),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await ReservationCubit.getInstance(context)
                            .loadMyOrders(refreshPage: true);
                      },
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 4),
                        itemCount: reservations.length,
                        itemBuilder: (context, index) => TrimCard(
                          child: ReservationItem(
                              reservation: reservations[index],
                              fontSize: fontSize,
                              showMoreDetails: true),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
