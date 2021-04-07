import 'package:flutter/foundation.dart';

class SalonService {
  String serviceName;
  int price;
  bool selected;
  String discription;
  SalonService(
      {@required this.serviceName,
      @required this.price,
      this.discription,
      this.selected = false});
}
