import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/home/models/salon_service.dart';
import 'package:trim/modules/home/repositories/salons_repo.dart';
import 'package:trim/modules/market/models/Product.dart';
import 'package:trim/modules/payment/cubits/payment_cubit.dart';
import 'package:trim/modules/reservation/cubits/update_order_states.dart';
import 'package:trim/modules/reservation/models/order_model.dart';
import 'package:trim/modules/reservation/repositries/update_order_repo.dart';

class UpdateOrderCubit extends Cubit<UpdateOrderStates> {
  final OrderModel order;
  List<SalonService> allServices = [];
  List<Product> products = [];
  UpdateOrderCubit({@required this.order}) : super(null) {
    if (order.paymentMethod.toLowerCase() ==
        getPaymentMethodString(PaymentMethod.Cash).toLowerCase())
      paymentMethod = PaymentMethod.Cash;
    if (order.paymentMethod.toLowerCase() ==
        getPaymentMethodString(PaymentMethod.VisaMaster).toLowerCase())
      paymentMethod = PaymentMethod.VisaMaster;
  }

  static UpdateOrderCubit getInstance(context) => BlocProvider.of(context);

  PaymentMethod paymentMethod = PaymentMethod.Cash;
  List<String> availableTimes = [];
  DateTime selectedDate;
  int selectedTimeIndex = 0;

  Future<void> extractOrderData() async {
    emit(LoadingOrderData());
    final res = await getSalonProfileFromServer(int.parse(order.barberId));
    if (res.error) {
      emit(ErrorOrderData(res.errorMessage));
      return;
    }

    emit(LoadedOrderData());
    allServices = [];
    final salon = res.data.salon;
    allServices.addAll(salon.salonServices);
    print(allServices.length);
    allServices = allServices.map((service) {
      int index =
          order.services.indexWhere((element) => service.id == element.id);
      if (index != -1) service.selected = true;

      return service;
    }).toList();
    selectedDate = selectedDate == null
        ? DateTime.parse(order.reservationDay)
        : selectedDate;
    print('$selectedDate   ${order.reservationDay}');
    await getAvailableDates();
    selectedTimeIndex =
        availableTimes.indexWhere((time) => time == order.reservationTime);
    if (selectedTimeIndex == -1) selectedTimeIndex = 0;
  }

  Future<void> getAvailableDates() async {
    emit(GettingAvilableTimes());
    final res = await getAvailableDatesFromServer(
        id: int.parse(order.barberId), date: selectedDate);
    if (res.error) {
      emit(ErrorOrderData(res.errorMessage));
      return;
    } else {
      if (res.data.avilableDates.isEmpty)
        emit(NoAvailableDates());
      else {
        availableTimes = res.data.avilableDates;
        emit(SuccessAvilableTimes());
      }
    }
  }

  Future<void> updateSalonOrder() async {
    final selectedServices =
        allServices.where((service) => service.selected).toList();
    if (selectedServices.isEmpty) {
      emit(NoSelectedServices());
      return;
    }
    emit(UpdatingOrder());
    final body = order.toMap();
    body.addAll({
      'order_id': order.id,
      'services': selectedServices.map((service) => service.toJson()).toList(),
      'payment_method': getPaymentMethodString(paymentMethod),
      'reservation_day': selectedDate.toString(),
      'reservation_time': availableTimes[selectedTimeIndex]
    });
    final res = await updateOrderFromServer(body);
    if (res.error) {
      print(res.errorMessage);
      emit(ErrorUpdateOrder(res.errorMessage));
    } else {
      emit(UpdatedOrder());
    }
  }

  void changeSelectedPaymentMethod(PaymentMethod method) {
    paymentMethod = method;
    emit(ChangePaymentMethod());
  }

  void changeSelectedDate(DateTime date) {
    selectedDate = date;
    selectedTimeIndex = 0;
    getAvailableDates();
  }

  void changeSelectedTimeIndex(index) {
    selectedTimeIndex = index;
    emit(ChangeTime());
  }

  void toggleSelectedService(int serviceId) {
    int index = allServices.indexWhere((element) => element.id == serviceId);
    allServices[index].selected = !allServices[index].selected;
    emit(ToggleServiceSelected());
  }

  String get getSlectedTime => availableTimes[selectedTimeIndex];
}
