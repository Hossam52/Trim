import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/settings/cubits/settings_states.dart';
import '../repositries/settings_repo.dart';
import '../models/contact_email_model.dart';
import '../models/contact_phone_model.dart';

class SettingCubit extends Cubit<SettingsStatates> {
  SettingCubit() : super(IntialSettingState()) {
    _loadContacts();
  }
  static SettingCubit getInstance(BuildContext context) =>
      BlocProvider.of(context);

  List<ContactPhoneModel> phones = [];
  List<ContactEmailModel> emails = [];

  Future<void> _loadContacts() async {
    emit(LoadingContactsSettingState());
    final response = await getCtonatctsFromServer();
    if (response.error) {
      print(response.errorMessage);
      emit(ErrorSettingState(response.errorMessage));
    } else {
      phones = response.data.contactPhones;
      emails = response.data.contactEmails;
      emit(LoadedContactsSettingState());
    }
  }
}
