import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trim/basic_data_model.dart';
import 'package:trim/modules/home/models/salon_offer.dart';
import 'package:trim/modules/home/models/salon_service.dart';
import 'package:trim/modules/home/models/trim_star_model.dart';
import 'package:trim/modules/home/models/rater_model.dart';

class Salon extends BasicData {
  List<DateTime> availableDatas = [];
  int id;
  String name;
  String email;
  String phone;
  String image;
  String governorateEn;
  String governorateAr;
  String gender;
  double rate;
  int commentsCount;
  String address;
  double lat;
  double lang;
  LatLng latLng;
  String status;
  String openFrom;
  String openTo;
  bool isFavorite;
  List<SalonService> salonServices;
  List<SalonOffer> salonOffers;
  List<RateModel> rates;
  Salon(
      {this.id,
      this.email,
      this.phone,
      this.governorateEn,
      this.governorateAr,
      this.gender,
      this.commentsCount,
      this.lat,
      this.lang,
      this.latLng,
      this.isFavorite,
      this.address,
      this.image,
      this.name,
      this.rate,
      this.status,
      this.openTo,
      this.availableDatas,
      this.openFrom,
      this.salonServices,
      this.salonOffers,
      this.rates});
  Salon.fromTrimStar(TrimStarModel model) {
    id = model.id;
    image = model.image;
    name = model.name;
    rate = model.rate;
  }
  Salon.fromTrimStarJson({Map<String, dynamic> json}) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    rate = (json['rate'] as int).toDouble();
  }

  Salon.fromJson({Map<String, dynamic> json}) {
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.phone = json['phone'];
    this.image = json['image'];
    this.governorateEn = json['governorate_en'];
    this.governorateAr = json['governorate_ar'];
    this.nameEn = json['city_en'];
    this.nameAr = json['city_ar'];
    this.gender = json['gender'];
    this.rate = ((json['rate'] ?? 0) as int).toDouble();
    this.commentsCount = json['commentsCount'];
    this.lat = double.tryParse(json['lat'].toString()) ?? 0;
    this.lang = double.tryParse(json['lang'].toString()) ?? 0;
    this.address = json['address'];
    this.status = json['status'];
    this.isFavorite = json['is_fav'];
    this.openFrom = json['from'];
    this.openTo = json['to'];
    if (json['services'] != null) {
      this.salonServices = <SalonService>[];
      json['services'].forEach((service) {
        this.salonServices.add(SalonService.fromJson(service));
      });
    }

    if (json['rates'] != null) {
      rates = [];
      json['rates'].forEach((rate) {
        rates.add(RateModel.fromJson(json: rate));
      });
    }
    if (json['offers'] != null) {
      this.salonOffers = <SalonOffer>[];
      json['offers'].forEach((offer) {
        this.salonOffers.add(SalonOffer.fromJson(json: offer));
      });
    }
  }
  String toString() {
    return '''id:$id,name:$name,address:$address,email:$email,'image:$image
    ''';
  }
}
