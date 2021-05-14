import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/reservation/cubits/reservation_states.dart';
import 'package:trim/modules/reservation/models/order_model.dart';
import 'package:trim/modules/reservation/repositries/reservation_repo.dart';

class ReservationCubit extends Cubit<ReservationStates> {
  ReservationCubit() : super(IntialReservationState()) {
    loadMyOrders(refreshPage: false);
  }

  static ReservationCubit getInstance(BuildContext context) =>
      BlocProvider.of<ReservationCubit>(context);
  List<OrderModel> reservations = [];
  OrderModel _selectedReservationItem;
  Future<void> loadMyOrders({@required bool refreshPage}) async {
    if (!refreshPage) emit(LoadingReservationState());
    final response = await loadMyOrdersFromServer();
    if (response.error) {
      emit(ErrorReservationState(response.errorMessage));
    } else {
      reservations = response.data.myReservations;
      emit(LoadedReservationStates());
    }
  }

  Future<void> cancelOrder(
      {@required int orderId, @required String cancelReason}) async {
    emit(LoadingCancelReservationState());
    final response = await cancelOrderFromServer(
        orderId: orderId, cancelReason: cancelReason);
    loadMyOrders(refreshPage: true);
    emit(LoadedCancedReservationState());
  }

  void setSelectedReservationItem(OrderModel orderModel) {
    _selectedReservationItem = orderModel;
  }

  OrderModel getSelectedReservationItem() {
    return _selectedReservationItem;
  }
}
