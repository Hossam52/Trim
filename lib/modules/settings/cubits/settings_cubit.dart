import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/modules/home/cubit/app_cubit.dart';
import 'package:trim/modules/home/cubit/persons_cubit.dart';
import 'package:trim/modules/home/cubit/salons_cubit.dart';
import 'package:trim/modules/market/cubit/cart_cubit.dart';
import 'package:trim/modules/reservation/cubits/reservation_cubit.dart';
import 'package:trim/modules/settings/cubits/settings_states.dart';
import 'package:trim/modules/settings/models/notification_model.dart';
import 'package:trim/modules/settings/screens/notifications_screen.dart';
import 'package:trim/utils/services/sercure_storage_service.dart';
import '../repositries/settings_repo.dart';
import '../models/contact_email_model.dart';
import '../models/contact_phone_model.dart';

class SettingCubit extends Cubit<SettingsStatates> {
  SettingCubit() : super(IntialSettingState());
  int notificationPageNumber = 1;

  static SettingCubit getInstance(BuildContext context) =>
      BlocProvider.of(context);

  List<ContactPhoneModel> phones = [];
  List<ContactEmailModel> emails = [];
  List<NotificationModel> notifications = [];

  Future<void> loadContacts() async {
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

  Future<void> loadNotifications(bool refreshPage) async {
    emit(LoadingNotificationState());
    final response = await getNotificationsFromServer(
        refreshPage ? notificationPageNumber : notificationPageNumber + 1);
    if (response.error)
      emit(ErrorNotificationState(response.errorMessage));
    else {
      if (response.data.notifications.isEmpty) {
        emit(NoMoreNotificationsState());
        await Future.delayed(Duration(seconds: 1));
        emit(LoadedNotificationState());
      } else {
        notificationPageNumber++;
        notifications = response.data.notifications;
        emit(LoadedNotificationState());
      }
    }
  }

  Future<void> loadPreviousPageNotifications() async {
    emit(LoadingNotificationState());
    final response =
        await getNotificationsFromServer(notificationPageNumber - 1);
    if (response.error)
      emit(ErrorNotificationState(response.errorMessage));
    else {
      if (response.data.notifications.isEmpty) {
        emit(NoMoreNotificationsState());
        await Future.delayed(Duration(seconds: 1));
        emit(LoadedNotificationState());
      } else {
        notificationPageNumber--;
        notifications = response.data.notifications;
        emit(LoadedNotificationState());
      }
    }
  }

  void loadPrevious() {
    if (notificationPageNumber != 1) loadPreviousPageNotifications();
  }

  void navigateToNotificationsScreen(BuildContext context) {
    loadNotifications(true);
    Navigator.pushNamed(context, NotificationScreen.routeName);
  }

  Future<void> logoutUser(BuildContext context) async {
    SalonsCubit.getInstance(context).resetData();
    PersonsCubit.getInstance(context).resetData();
    ReservationCubit.getInstance(context).resetData();
    BlocProvider.of<CartBloc>(context).resetData();

    TrimShared.removeProfileData();
    await AppCubit.getInstance(context).reloadData(context);
  }
}
