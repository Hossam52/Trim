class NotificationModel {
  int id;
  String data;
  String createdAt;
  String readAt;
  NotificationModel.fromJson({Map<String, dynamic> json}) {
    id = json['id'];
    data = json['data'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
  }
}

class NotificationsModel {
  List<NotificationModel> notifications = [];
  NotificationsModel.fromJson({Map<String, dynamic> json}) {
    if (json['data'] != null) {
      notifications = [];
      final data = json['data'] as List<dynamic>;
      data.forEach((notification) {
        notifications.add(NotificationModel.fromJson(json: notification));
      });
    }
  }
}
