import 'package:flutter/material.dart';
import 'package:trim/appLocale/translatedWord.dart';
import 'package:trim/modules/settings/models/notification_model.dart';
import 'package:trim/utils/ui/Core/Models/DeviceInfo.dart';

class NotificationItem extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final NotificationModel notification;

  const NotificationItem(
      {Key key, @required this.deviceInfo, @required this.notification})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              notification.data ?? translatedWord('Unknown', context),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.grey, fontSize: deviceInfo.localWidth * 0.045),
            ),
          ),
        ),
        Expanded(
          child: FittedBox(
            child: Text(
                notification.createdAt ?? translatedWord('Unknown', context)),
          ),
        )
      ],
    );
  }
}
