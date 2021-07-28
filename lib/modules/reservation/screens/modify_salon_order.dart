import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/general_widgets/confirm_cancel_buttons.dart';
import 'package:trim/general_widgets/empty_time_day.dart';
import 'package:trim/general_widgets/trim_loading_widget.dart';
import 'package:trim/general_widgets/retry_widget.dart';
import 'package:trim/modules/home/widgets/available_times.dart';
import 'package:trim/modules/home/widgets/date_builder.dart';
import 'package:trim/modules/home/widgets/salon_services.dart';
import 'package:trim/modules/reservation/cubits/update_order_cubit.dart';
import 'package:trim/modules/reservation/cubits/update_order_states.dart';
import 'package:trim/modules/reservation/models/UpdateArea.dart';
import 'package:trim/modules/reservation/models/order_model.dart';

class ModifySalonOrder extends StatelessWidget {
  static String routeName = '/modify-salon-order';
  ModifySalonOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context).settings.arguments as OrderModel;

    return BlocProvider(
      create: (_) => UpdateOrderCubit(order: order)..extractOrderData(),
      child: Builder(
        builder: (context) => SafeArea(
          child: Scaffold(
            body: BlocConsumer<UpdateOrderCubit, UpdateOrderStates>(
              listener: (_, state) {
                if (state is UpdatedOrder) {
                  Fluttertoast.showToast(
                      msg: translatedWord(
                          'Order updated successifully', context),
                      backgroundColor: Colors.green);
                  Navigator.pop(context, true);
                }

                if (state is NoSelectedServices)
                  Fluttertoast.showToast(
                      msg: translatedWord(
                          'You should select at least one service', context),
                      backgroundColor: Colors.red);

                if (state is ErrorOrderData)
                  Fluttertoast.showToast(msg: state.error);
              },
              builder: (_, state) {
                if (state is LoadingOrderData) return TrimLoadingWidget();
                if (state is ErrorOrderData)
                  return RetryWidget(
                      text: state.error,
                      onRetry: () async {
                        await UpdateOrderCubit.getInstance(context)
                            .extractOrderData();
                      });
                if (state is ErrorUpdateOrder)
                  return RetryWidget(
                      text: state.error,
                      onRetry: () {
                        UpdateOrderCubit.getInstance(context)
                            .updateSalonOrder();
                      });

                final List<UpdateArea> tabs = allTabs(context);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: DefaultTabController(
                        length: tabs.length,
                        initialIndex: 0,
                        child: Column(
                          children: [
                            TabBar(
                                isScrollable: true,
                                labelColor: Theme.of(context).primaryColor,
                                tabs: tabs.map((t) => t.tabWidget).toList()),
                            Expanded(
                              child: TabBarView(
                                  children: tabs
                                      .map((t) => t.contentWidget)
                                      .toList()),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildOrderActions(context),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOrderActions(context) {
    return BlocBuilder<UpdateOrderCubit, UpdateOrderStates>(
      builder: (_, state) {
        if (state is UpdatingOrder) return TrimLoadingWidget();
        return ConfirmCancelButtons(
          onPressConfirm: () async =>
              await UpdateOrderCubit.getInstance(context).updateSalonOrder(),
        );
      },
    );
  }

  List<UpdateArea> allTabs(BuildContext context) {
    return [
      UpdateArea(
          text: translatedWord('Modify', context),
          contentWidget: SingleChildScrollView(
            child: SalonServices(
                services: UpdateOrderCubit.getInstance(context).allServices,
                onItemToggled: UpdateOrderCubit.getInstance(context)
                    .toggleSelectedService),
          )),
      UpdateArea(
        text: translatedWord('Change date', context),
        contentWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDateSelection(context),
              BlocBuilder<UpdateOrderCubit, UpdateOrderStates>(
                  builder: (_, state) {
                if (state is GettingAvilableTimes)
                  return TrimLoadingWidget();
                else if (state is NoAvailableDates) return EmptyTimeAtDay();
                return AvailableTimes(
                  dates: UpdateOrderCubit.getInstance(context).availableTimes,
                  onDateChange: UpdateOrderCubit.getInstance(context)
                      .changeSelectedTimeIndex,
                  selectedIndex:
                      UpdateOrderCubit.getInstance(context).selectedTimeIndex,
                );
              }),
            ],
          )),
        ),
      ),
      // UpdateArea(
      //     text: translatedWord('Change payment method', context),
      //     contentWidget: PaymentMethodsWidget(
      //       onChangeSelection: (val) {
      //         UpdateOrderCubit.getInstance(context)
      //             .changeSelectedPaymentMethod(val);
      //       },
      //       paymentMethod: UpdateOrderCubit.getInstance(context).paymentMethod,
      //       showCashMethod: true,
      //     )),
    ];
  }

  DateBuilder buildDateSelection(BuildContext context) {
    return DateBuilder(
        onChangeDate: (date) =>
            UpdateOrderCubit.getInstance(context).changeSelectedDate(date),
        initialSelectedDate:
            UpdateOrderCubit.getInstance(context).selectedDate);
  }
}
