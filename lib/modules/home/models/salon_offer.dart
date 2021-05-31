import 'package:trim/basic_data_model.dart';

class SalonOffer extends BasicData {
  int id;
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
      this.price,
      this.salon,
      this.qty});

  SalonOffer.fromJson({Map<String, dynamic> json}) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    price = json['price'];
    image = json['image'];
    salon = json['salon'];
    categoryAr = json['category_ar'];
    categoryEn = json['category_en'];
    qty = json['qty'];
  }
}
