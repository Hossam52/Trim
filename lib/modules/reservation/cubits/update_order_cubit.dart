import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/home/models/salon_service.dart';
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

  ///==================products========================///
  void getAllProducsts() {
    emit(LoadingOrderData());
    products = order.products.toList();
    emit(LoadedOrderData());
  }

  void updateProductPlus(int index) {
    int quantity = int.parse(products[index].productQuantity);
    quantity++;
    products[index].productQuantity = quantity.toString();
    emit(ChangeQuantityProduct());
  }

  void updateProductMinus(int index) {
    int quantity = int.parse(products[index].productQuantity);
    if (quantity >= 2) {
      quantity--;
      products[index].productQuantity = quantity.toString();
    } else
      products.removeAt(index);
    emit(ChangeQuantityProduct());
  }

  void removeProduct(int index) {
    products.removeAt(index);
    emit(RemoveProduct());
  }

  ///==================Services========================///
  Future<void> getServices(BuildContext context) async {
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
  }

  void changeSelectedPaymentMethod(PaymentMethod method) {
    paymentMethod = method;
    emit(ChangePaymentMethod());
  }

  void toggleSelectedService(int serviceId) {
    int index = allServices.indexWhere((element) => element.id == serviceId);
    allServices[index].selected = !allServices[index].selected;
    emit(ToggleServiceSelected());
  }

  Future<void> updateSalonOrder({
    @required DateTime reservationDate,
    @required String reservationTime,
  }) async {
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
      'reservation_day': reservationDate.add(Duration(days: 5)).toString(),
      'reservation_time': reservationTime
    });
    final res = await updateOrderFromServer(body);
    if (res.error) {
      print(res.errorMessage);
      emit(ErrorUpdateOrder(res.errorMessage));
    } else {
      emit(UpdatedOrder());
    }
  }
}
