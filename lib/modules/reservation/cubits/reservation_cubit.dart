import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/reservation/cubits/reservation_states.dart';
import 'package:trim/modules/reservation/models/order_model.dart';
import 'package:trim/modules/reservation/repositries/reservation_repo.dart';

class ReservationCubit extends Cubit<ReservationStates> {
  ReservationCubit() : super(IntialReservationState());
  bool loadDataForFirstTime = true;
  static ReservationCubit getInstance(BuildContext context) =>
      BlocProvider.of<ReservationCubit>(context);
  List<OrderModel> reservations = [];
  OrderModel _selectedReservationItem;
  Future<void> loadMyOrders({@required bool refreshPage}) async {
    if (!refreshPage || loadDataForFirstTime) emit(LoadingReservationState());
    final response = await loadMyOrdersFromServer();
    if (response.error) {
      emit(ErrorReservationState(response.errorMessage));
    } else {
      loadDataForFirstTime = false;
      reservations = response.data.myReservations;
      emit(LoadedReservationStates());
    }
  }

  Future<void> cancelOrder(
      {@required int orderId, @required String cancelReason}) async {
    emit(LoadingCancelReservationState());
    await cancelOrderFromServer(orderId: orderId, cancelReason: cancelReason);
    loadMyOrders(refreshPage: true);

    emit(LoadedCancedReservationState());
  }

  void setSelectedReservationItem(OrderModel orderModel) {
    _selectedReservationItem = orderModel;
  }

  OrderModel getSelectedReservationItem() {
    return _selectedReservationItem;
  }

  void resetData() {
    reservations.clear();
    _selectedReservationItem = null;
    loadDataForFirstTime = true;
  }
}
