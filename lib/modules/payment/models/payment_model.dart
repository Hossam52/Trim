class PaymentModel {
  String id;
  String actionId;
  int amount;
  bool approved;
  String status;
  String reference;
  SourcePayment sourcePayment;

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    actionId = json['action_id'];
    amount = json['amount'];
    approved = json['approved'];
    status = json['status'];
    reference = json['reference'];
    sourcePayment = SourcePayment.fromJson(json['source']);
  }
}

class SourcePayment {
  String type;
  String id;

  SourcePayment.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
  }
}
