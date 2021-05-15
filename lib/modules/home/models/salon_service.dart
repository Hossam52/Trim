import 'package:flutter/foundation.dart';
import 'package:trim/basic_data_model.dart';

class SalonService extends BasicData {
  int id;
  String priceType;
  String price;
  // String titleEn;
  // String titleAr;
  bool selected;
  String descriptionEn;
  String descriptionAr;
  SalonService(
      {this.id,
      this.priceType,
      this.price,
      // this.titleEn,
      // this.titleAr,
      this.descriptionEn,
      this.descriptionAr,
      this.selected = false});

  SalonService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priceType = json['price_type'];
    price = json['price'];
    nameEn = json['title_en'];
    nameAr = json['title_ar'];
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    selected = false;
  }
  Map<String, dynamic> toJson() {
    return {'service_id': id, 'quantity': 1};
  }
}
