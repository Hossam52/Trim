import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trim/appLocale/getWord.dart';
import 'package:trim/general_widgets/no_data_widget.dart';
import 'package:trim/general_widgets/trim_loading_widget.dart';
import 'package:trim/general_widgets/no_more_items.dart';
import 'package:trim/general_widgets/retry_widget.dart';
import 'package:trim/modules/home/widgets/navigate_pages.dart';
import 'package:trim/modules/settings/cubits/settings_cubit.dart';
import 'package:trim/modules/settings/cubits/settings_states.dart';
import 'package:trim/modules/settings/widgets/notification_item.dart';
import 'package:trim/utils/ui/Core/BuilderWidget/InfoWidget.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = '/notification';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getWord('notifications', context),
            style: TextStyle(color: Colors.black)),
        leading: BackButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<SettingCubit, SettingsStatates>(
        listener: (_, state) {},
        builder: (_, state) {
          if (state is LoadingNotificationState) return TrimLoadingWidget();
          if (state is ErrorNotificationState)
            return RetryWidget(
              text: state.error,
              onRetry: () =>
                  SettingCubit.getInstance(context).loadNotifications(true),
            );
          final notifications = SettingCubit.getInstance(context).notifications;
          if (notifications.isEmpty) return EmptyDataWidget();
          return Column(
            children: [
              Expanded(
                child: InfoWidget(
                    responsiveWidget: (context, deviceInfo) => Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: notifications.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: deviceInfo.localHeight /
                                        (deviceInfo.orientation ==
                                                Orientation.portrait
                                            ? 5
                                            : 3),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      margin: const EdgeInsets.all(10.0),
                                      elevation: 6,
                                      child: NotificationItem(
                                          deviceInfo: deviceInfo,
                                          notification: notifications[index]),
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (state is NoMoreNotificationsState)
                              NoMoreItems(
                                  deviceInfo: deviceInfo,
                                  label: 'No More Notifications')
                          ],
                        )),
              ),
              BlocBuilder<SettingCubit, SettingsStatates>(
                builder: (_, state) => NavigatePages(
                  nextPage: (_) async => await SettingCubit.getInstance(context)
                      .loadNotifications(false),
                  prevPage: (_) =>
                      SettingCubit.getInstance(context).loadPrevious(),
                  pageNumber:
                      SettingCubit.getInstance(context).notificationPageNumber,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
