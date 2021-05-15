class RefundModel {
  String actionId;
  String reference;

  RefundModel.fromJson(Map<String, dynamic> json) {
    actionId = json['action_id'];
    reference = json['reference'];
  }
}
