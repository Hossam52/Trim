import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/modules/payment/cubits/address_states.dart';
import 'package:trim/utils/services/sercure_storage_service.dart';

class AddressCubit extends Cubit<AddressStates> {
  AddressCubit() : super(IntialAddressState()) {
    initalizeData();
  }
  static AddressCubit getInstance(context) =>
      BlocProvider.of<AddressCubit>(context);

  String city;
  String phone;
  String country;
  String street;
  void initalizeData() async {
    phone = await TrimShared.getDataFromShared('deliveryPhone');
    street = await TrimShared.getDataFromShared('deliveryStreet');
    country = await TrimShared.getDataFromShared('deliveryCountry');
    city = await TrimShared.getDataFromShared('deliveryCity');
  }

  bool validAddressData(
      {@required String enteredCity,
      @required String enteredPhone,
      @required String enteredCountry,
      @required String enteredStreet}) {
    if (enteredCity == null ||
        enteredPhone == null ||
        enteredStreet == null ||
        enteredCountry == null) return false;
    return true;
  }

  bool validateClassData() {
    if (city == null || phone == null || street == null || country == null)
      return false;
    return true;
  }

  Future<void> changeDeliveryData({
    @required String enteredCity,
    @required String enteredPhone,
    @required String enteredCountry,
    @required String enteredStreet,
  }) async {
    if (validAddressData(
        enteredCity: enteredCity,
        enteredCountry: enteredCountry,
        enteredPhone: enteredPhone,
        enteredStreet: enteredStreet)) {
      city = enteredCity;
      phone = enteredPhone;
      country = enteredCountry;
      street = enteredStreet;
      await TrimShared.storeDeliveryData(
        city: city,
        street: street,
        country: country,
        phone: phone,
      );

      emit(SuccessChangeDelivery());
    } else {
      emit(FailedChangeDelivery());
    }
  }

  String getCity(BuildContext context) =>
      city ?? translatedWord('Unknown', context);
  String getStreet(BuildContext context) =>
      street ?? translatedWord('Unknown', context);
  String getPhone(BuildContext context) =>
      phone ?? translatedWord('Unknown', context);
  String getCountry(BuildContext context) =>
      country ?? translatedWord('Unknown', context);
}
