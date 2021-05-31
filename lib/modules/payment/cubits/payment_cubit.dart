import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:trim/modules/payment/repositires/payment_repo.dart';
import './payment_states.dart';

enum PaymentMethod { Cash, VisaMaster }

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(IntialPaymentState()) {
    initPayment();
  }
  PaymentMethod paymentMethod = PaymentMethod.Cash;
  static PaymentCubit getInstance(context) => BlocProvider.of(context);
  CreditCardModel cardModel = CreditCardModel('', '', '', '', false);
  String token = '';
  bool successPayment = false;

//----------------API Calls START-----------------
  Future<void> _getToken(CreditCardModel card) async {
    emit(LoadingTokenState());
    final response = await getTokenFromServer(
        cardNumber: card.cardNumber.replaceAll(' ', ''),
        expiryMonth: card.expiryDate[0] + card.expiryDate[1],
        expiryYear: card.expiryDate[3] + card.expiryDate[4],
        name: card.cardHolderName,
        cvv: card.cvvCode);
    if (response.error) {
      emit(ErrorPaymentState(response.errorMessage));
      print('Payment Error ${response.errorMessage}');
    } else {
      token = response.data;
      emit(LoadedTokenState());
      print('User Token is ${response.data}');
    }
  }

  Future<void> makePayment(int amount) async {
    emit(LoadingPaymentState());
    final response = await makePaymentFromServer(
      amount: amount * 100, // as we act with qersh
      token: token,
    );
    if (response.error) {
      emit(ErrorPaymentState(response.errorMessage));
    } else {
      successPayment = true;
      emit(LoadedPaymentState());
      print('Payment Token ${response.data.id}');
    }
  }

  Future<void> refundMoney(String id) async {
    final response = await makeRefund(id: id, amount: 0);
    if (response.error) {
    } else {}
  }

  Future<void> paymentProducts(
      {@required CreditCardModel card,
      @required int amount,
      String orderId}) async {
    await _getToken(card);
    if (state is! ErrorPaymentState) {
      emit(LoadingPaymentState());
      final response = await makePaymentFromServer(
        token: token,
        amount: amount * 100,
        reference: orderId,
      );
      if (response.error) {
        emit(ErrorPaymentState(response.errorMessage));
      } else {
        emit(LoadedPaymentState());
      }
    }
  }
//-------------------API Calls END--------------

  void changeSelectedPaymentMethod(PaymentMethod method) {
    if (method != paymentMethod) {
      paymentMethod = method;
      emit(ChangePaymentMethodState());
    }
  }

  void payService(int amount) async {
    successPayment = false;
    await _getToken(cardModel);
  }

  void clearCreditCardData() {
    cardModel.cardHolderName = '';
    cardModel.cardNumber = '';
    cardModel.cvvCode = '';
    cardModel.expiryDate = '';
  }

  void changeCreditCardData(CreditCardModel card) {
    cardModel = card;
    emit(ChangeCardDataState());
  }
}
