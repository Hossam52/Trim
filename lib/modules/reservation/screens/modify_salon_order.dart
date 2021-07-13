import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/constants/app_constant.dart';
import 'package:trim/general_widgets/default_button.dart';
import 'package:trim/general_widgets/no_more_items.dart';
import 'package:trim/general_widgets/retry_widget.dart';
import 'package:trim/modules/home/models/salon_service.dart';
import 'package:trim/modules/home/screens/reserve_screen.dart';
import 'package:trim/modules/home/widgets/available_times.dart';
import 'package:trim/modules/home/widgets/date_builder.dart';
import 'package:trim/modules/home/widgets/salon_services.dart';
import 'package:trim/modules/payment/cubits/payment_cubit.dart';
import 'package:trim/modules/payment/screens/payment_methods_screen.dart';
import 'package:trim/modules/payment/widgets/payment_methods_widgets.dart';
import 'package:trim/modules/reservation/cubits/update_order_cubit.dart';
import 'package:trim/modules/reservation/cubits/update_order_states.dart';
import 'package:trim/modules/reservation/models/order_model.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class ModifySalonOrder extends StatelessWidget {
  static String routeName = '/modify-salon-order';
  ModifySalonOrder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context).settings.arguments as OrderModel;

    return BlocProvider(
      create: (_) => UpdateOrderCubit(order: order)..getServices(context),
      child: Builder(
        builder: (context) => SafeArea(
          child: Scaffold(
            body: BlocConsumer<UpdateOrderCubit, UpdateOrderStates>(
              listener: (_, state) {
                if (state is UpdatedOrder) {
                  Fluttertoast.showToast(
                      msg: 'Order updated successifully',
                      backgroundColor: Colors.green);
                  Navigator.pop(context, true);
                }

                if (state is NoSelectedServices)
                  Fluttertoast.showToast(
                      msg: getWord(
                          'You should select at least one service', context),
                      backgroundColor: Colors.red);

                if (state is ErrorOrderData)
                  Fluttertoast.showToast(msg: state.error);
              },
              builder: (_, state) {
                if (state is LoadingOrderData)
                  return Center(child: CircularProgressIndicator());
                if (state is ErrorOrderData)
                  return RetryWidget(
                      text: state.error,
                      onRetry: () async {
                        await UpdateOrderCubit.getInstance(context)
                            .getServices(context);
                      });
                if (state is ErrorUpdateOrder)
                  return RetryWidget(
                      text: state.error,
                      onRetry: () {
                        UpdateOrderCubit.getInstance(context).updateSalonOrder(
                            reservationDate: DateTime.now(),
                            reservationTime: '5:00 PM');
                      });

                final List<UpdateArea> tabs = allTabs(context);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: DefaultTabController(
                        length: 3,
                        initialIndex: 1,
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
        if (state is UpdatingOrder)
          return Center(
            child: CircularProgressIndicator(),
          );
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: DefaultButton(
              text: getWord('Confirm', context),
              onPressed: () async {
                await UpdateOrderCubit.getInstance(context).updateSalonOrder(
                    reservationDate: DateTime.now(),
                    reservationTime: '5:00 PM');
              },
              color: Colors.green,
            )),
            SizedBox(
              width: 70,
            ),
            Expanded(
                child: DefaultButton(
                    text: getWord('Cancel', context),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.red)),
          ],
        );
      },
    );
  }

  List<UpdateArea> allTabs(BuildContext context) {
    return [
      UpdateArea(
          text: getWord('Modify', context),
          contentWidget: SingleChildScrollView(
            child: BlocBuilder<UpdateOrderCubit, UpdateOrderStates>(
              buildWhen: (_, newState) {
                if (newState is ToggleServiceSelected) return true;
                return false;
              },
              builder: (_, state) => SalonServices(
                  services: UpdateOrderCubit.getInstance(context).allServices,
                  onItemToggled: UpdateOrderCubit.getInstance(context)
                      .toggleSelectedService),
            ),
          )),
      UpdateArea(
          text: getWord('Change date', context),
          contentWidget:
              Padding(padding: const EdgeInsets.all(8.0), child: Container())),
      UpdateArea(
          text: getWord('Change payment method', context),
          contentWidget: PaymentMethodsWidget(
            onChangeSelection: (val) {
              print(val);
              UpdateOrderCubit.getInstance(context)
                  .changeSelectedPaymentMethod(val);
            },
            paymentMethod: UpdateOrderCubit.getInstance(context).paymentMethod,
            showCashMethod: true,
          )),
    ];
  }
}

class UpdateArea {
  final String text;
  final Widget contentWidget;
  Tab tabWidget;
  UpdateArea({@required this.text, @required this.contentWidget}) {
    tabWidget = Tab(
      child: InfoWidget(
        responsiveWidget: (_, deviceInfo) => Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: getFontSizeVersion2(deviceInfo) * 0.8),
        ),
      ),
    );
  }
}
