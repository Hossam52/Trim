import 'package:flutter/foundation.dart';

class SalonOffer {
  int id;
  String nameEn;
  String nameAr;
  String descriptionAr;
  String descriptionEn;
  String price;
  String image;
  String salon;
  String categoryAr;
  String categoryEn;
  String qty;
  SalonOffer(
      {this.image,
      this.id,
      this.categoryAr,
      this.categoryEn,
      this.descriptionAr,
      this.descriptionEn,
      this.nameAr,
      this.nameEn,
      this.price,
      this.salon,
      this.qty});

  factory SalonOffer.fromJson({Map<String, dynamic> json}) {
    return SalonOffer(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      descriptionAr: json['description_ar'],
      descriptionEn: json['description_en'],
      price: json['price'],
      image: json['image'],
      salon: json['salon'],
      categoryAr: json['category_ar'],
      categoryEn: json['category_en'],
      qty: json['qty'],
    );
  }
}
