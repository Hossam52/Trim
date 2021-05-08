import 'package:flutter/foundation.dart';

class RateModel {
  int id;
  String user;
  String image;
  String salon;
  double rate;
  String comment;
  String createdAt;

  RateModel.fromJson({@required Map<String, dynamic> json}) {
    id = json['id'];
    user = json['user'];
    image = json['image'];
    salon = json['salon'];

    try {
      rate = (json['rate'] as int).toDouble();
    } catch (e) {
      rate = 0;
    }
    comment = json['comment'];
    createdAt = json['created_at'];
  }
}
