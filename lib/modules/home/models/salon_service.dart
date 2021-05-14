import 'package:flutter/foundation.dart';

class SalonService {
  int id;
  String priceType;
  String price;
  String titleEn;
  String titleAr;
  bool selected;
  String descriptionEn;
  String descriptionAr;
  SalonService(
      {this.id,
      this.priceType,
      this.price,
      this.titleEn,
      this.titleAr,
      this.descriptionEn,
      this.descriptionAr,
      this.selected = false});

  SalonService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priceType = json['price_type'];
    price = json['price'];
    titleEn = json['title_en'];
    titleAr = json['title_ar'];
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    selected = false;
  }
  Map<String, dynamic> toJson() {
    return {'service_id': id, 'quantity': 1};
  }
}
