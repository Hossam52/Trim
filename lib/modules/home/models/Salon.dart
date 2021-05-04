import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trim/modules/home/models/salon_offer.dart';
import 'package:trim/modules/home/models/salon_service.dart';
import 'package:trim/modules/home/models/trim_star_model.dart';
import 'package:trim/modules/home/models/rater_model.dart';

class Salon {
  List<DateTime> availableDatas = [];
  int id;
  String name;
  String email;
  String phone;
  String image;
  String governorateEn;
  String governorateAr;
  String cityEn;
  String cityAr;
  String gender;
  double rate;
  int commentsCount;
  String address;
  String lat;
  String lang;
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
      this.cityEn,
      this.cityAr,
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
    this.cityEn = json['city_en'];
    this.cityAr = json['city_ar'];
    this.gender = json['gender'];
    this.rate = ((json['rate'] ?? 0) as int).toDouble();
    this.commentsCount = json['commentsCount'];
    this.lat = json['lat'];
    this.lang = json['lang'];
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
    return '''id:$id,
              name:$name,
              address:$address,
              email:$email,
              'image:$image,

    
    
    ''';
  }
}

//   factory Salon.fromJson({Map<String, dynamic> json}) {
//     (json['services'] as List).forEach((service) {});
//     return Salon(
//       id: json['id'],
//       email: json['email'],
//       phone: json['phone'],
//       governorateEn: json['governorate_en'],
//       governorateAr: json['governorate_ar'],
//       cityEn: json['city_en'],
//       cityAr: json['city_ar'],
//       commentsCount: json['commentsCount'],
//       lat: json['lat'],
//       longitude: json['lang'],
//       isFavorite: json['is_fav'],
//       address: json['address'],
//       image: json['image'],
//       name: json['name'],
//       rate: (json['rate'] as int).toDouble(),
//       status: json['status'],
//       openTo: json['to'],
//       openFrom: json['from'],
//     );
//   }
// }

List<Salon> salonsData = [
  // Salon(
  //     isFavorite: "Open",
  //     image: 'assets/images/1.jpg',
  //     address: 'Ibrahime saqr, tagoa el 3 beside tawla cafee',
  //     name: 'الكسندرا صالون',
  //     status: "Open",
  //     rate:  3.5 ,
  //     cityEn: 'nasr'),
  // Salon(
  //     isFavorite: "Closed",
  //     image: 'assets/images/2.jpg',
  //     address: 'Shoubra alkhima egypt',
  //     name: 'Bianca beauty (hair salon)',
  //     status: "Open",
  //     rate: 5,
  //     cityEn: 'cairo'),
  // Salon(
  //   isFavorite: "Closed",
  //   image: 'assets/images/3.jpg',
  //   address: 'Al mhala el kobra city infront of suez canal',
  //   name: 'الكسندرا صالون',
  //   status: "Closed",
  //   rate: 4.5,
  //   cityEn: 'cairo',
  // ),
  // Salon(
  //     isFavorite: "Open",
  //     image: 'assets/images/4.jpg',
  //     address: 'Wadi qoraish in abbasia',
  //     name: 'الكسندرا صالون',
  //     status: "Closed",
  //     rate: 4.5,
  //     cityEn: 'nasr'),
  // Salon(
  //     isFavorite: "Open",
  //     image: 'assets/images/5.jpg',
  //     address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
  //     name: 'الكسندرا صالون',
  //     status: "Closed",
  //     rate: 4.5),
  // Salon(
  //     isFavorite: "Closed",
  //     image: 'assets/images/6.jpg',
  //     address: 'You are foolish gedn',
  //     name: 'الكسندرا صالون',
  //     status: "Open",
  //     rate: 4.5),
  // Salon(
  //   isFavorite: "Open",
  //   image: 'assets/images/3.jpg',
  //   address: 'Al mhala el kobra city infront of suez canal',
  //   name: 'سعيد صالون',
  //   status: "Closed",
  //   rate: 4.5,
  //   cityEn: 'cairo',
  // ),
  // Salon(
  //     isFavorite: "Closed",
  //     image: 'assets/images/4.jpg',
  //     address: 'المعادي الجديدة بعد تفريعة قناة السويس',
  //     name: 'سعيد حمادة',
  //     status: "Closed",
  //     rate: 4,
  //     cityEn: 'nasr'),
  // Salon(
  //     isFavorite: "Open",
  //     image: 'assets/images/5.jpg',
  //     address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
  //     name: 'Salon 1',
  //     status: "Closed",
  //     rate: 2),
  // Salon(
  //     isFavorite: "Open",
  //     image: 'assets/images/6.jpg',
  //     address: 'بهتيم شبرا الخيمة كشري الخدييوي ',
  //     name: 'صالون رزق',
  //     status: "Open",
  //     rate: 4.5),
  // Salon(
  //     isFavorite: "Closed",
  //     image: 'assets/images/2.jpg',
  //     address: 'Al sharqia at nasr street infront of alabd street',
  //     name: 'What you need ',
  //     status: "Open",
  //     rate: 3.5,
  //     cityEn: 'nasr'),
  // Salon(
  //     isFavorite: "Closed",
  //     image: 'assets/images/3.jpg',
  //     address: 'مدينة نصر للتعدين والاسكان امام فندم الماظة',
  //     name: 'Bianca beauty (hair salon)',
  //     status: "Open",
  //     rate: 5,
  //     cityEn: 'cairo'),
  // Salon(
  //   isFavorite: "Open",
  //   image: 'assets/images/1.jpg',
  //   address: 'Al mhala el kobra city infront of suez canal',
  //   name: 'سعيد صالون',
  //   status: "Closed",
  //   rate: 4.5,
  //   cityEn: 'cairo',
  // ),
  // Salon(
  //     isFavorite: "Open",
  //     image: 'assets/images/5.jpg',
  //     address: 'المعادي الجديدة بعد تفريعة قناة السويس',
  //     name: 'Donia',
  //     status: "Closed",
  //     rate: 4.5,
  //     cityEn: 'nasr'),
  // Salon(
  //     isFavorite: "Closed",
  //     image: 'assets/images/5.jpg',
  //     address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
  //     name: 'Salon 1',
  //     status: "Closed",
  //     rate: 4.5),
];

List<Salon> mostSearchSalons = [
  Salon(
      image: 'assets/images/1.jpg',
      address: 'Al sharqia at nasr street infront of alabd street',
      name: 'Beauty salon',
      status: "Open",
      rate: 3.5,
      cityEn: 'nasr'),
  Salon(
      image: 'assets/images/2.jpg',
      address: 'مدينة نصر للتعدين والاسكان امام فندم الماظة',
      name: 'Bianca beauty (hair salon)',
      status: "Open",
      rate: 5,
      cityEn: 'cairo'),
  Salon(
    image: 'assets/images/3.jpg',
    address: 'Al mhala el kobra city infront of suez canal',
    name: 'سعيد صالون',
    status: "Closed",
    rate: 4.5,
    cityEn: 'cairo',
  ),
  Salon(
      image: 'assets/images/4.jpg',
      address: 'المعادي الجديدة بعد تفريعة قناة السويس',
      name: 'سعيد حمادة',
      status: "Closed",
      rate: 4.5,
      cityEn: 'nasr'),
  Salon(
      image: 'assets/images/5.jpg',
      address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
      name: 'Salon 1',
      status: "Closed",
      rate: 4.5),
  Salon(
      image: 'assets/images/6.jpg',
      address: 'بهتيم شبرا الخيمة كشري الخدييوي ',
      name: 'صالون رزق',
      status: "Open",
      rate: 4.5),
  Salon(
      image: 'assets/images/2.jpg',
      address: 'Al sharqia at nasr street infront of alabd street',
      name: 'What you need ',
      status: "Open",
      rate: 3.5,
      cityEn: 'nasr'),
  Salon(
      image: 'assets/images/3.jpg',
      address: 'مدينة نصر للتعدين والاسكان امام فندم الماظة',
      name: 'Bianca beauty (hair salon)',
      status: "Open",
      rate: 5,
      cityEn: 'cairo'),
  Salon(
    image: 'assets/images/1.jpg',
    address: 'Al mhala el kobra city infront of suez canal',
    name: 'سعيد صالون',
    status: "Closed",
    rate: 4.5,
    cityEn: 'cairo',
  ),
  Salon(
      image: 'assets/images/5.jpg',
      address: 'المعادي الجديدة بعد تفريعة قناة السويس',
      name: 'Donia',
      status: "Closed",
      rate: 4.5,
      cityEn: 'nasr'),
  Salon(
      image: 'assets/images/5.jpg',
      address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
      name: 'Salon 1',
      status: "Closed",
      rate: 4.5),
  Salon(
      image: 'assets/images/2.jpg',
      address: 'بهتيم شبرا الخيمة كشري الخدييوي ',
      name: 'صالون رزق',
      status: "Open",
      rate: 4.5),
];

//       LatLng(30.133912262634386, 31.273745745420456),
//       LatLng(30.132346728940966, 31.274213790893555),
//       LatLng(30.130133075858343, 31.273340061306953),
//       LatLng(30.135126338811588, 31.268736720085144),
//       LatLng(30.130025204672926, 31.268970742821693),
//       LatLng(30.138406328553632, 31.278630048036575),
//       LatLng(30.13260277180459, 31.278349086642265),
//       LatLng(30.128419301957575, 31.277475357055664),
//       LatLng(30.139566419055328, 31.272169947624207),
//       LatLng(30.142036168906582, 31.275899559259415),
List<Salon> mapSalons = [
  // Salon(
  //     latLng: LatLng(30.133912262634386, 31.273745745420456),
  //     image: 'assets/images/1.jpg',
  //     address: 'Ibrahime saqr, tagoa el 3 beside tawla cafee',
  //     name: 'الكسندرا صالون',
  //     status: "Open",
  //     rate: 3.5,
  //     cityEn: 'nasr'),
  // Salon(
  //     latLng: LatLng(30.132346728940966, 31.274213790893555),
  //     image: 'assets/images/2.jpg',
  //     address: 'Shoubra alkhima egypt',
  //     name: 'Bianca beauty (hair salon)',
  //     status: "Open",
  //     rate: 5,
  //     cityEn: 'cairo'),
  // Salon(
  //   latLng: LatLng(30.130133075858343, 31.273340061306953),
  //   image: 'assets/images/3.jpg',
  //   address: 'Al mhala el kobra city infront of suez canal',
  //   name: 'فتحي الحلاق',
  //   status: "Closed",
  //   rate: 4.5,
  //   cityEn: 'cairo',
  // ),
  // Salon(
  //     latLng: LatLng(30.135126338811588, 31.268736720085144),
  //     image: 'assets/images/4.jpg',
  //     address: 'Wadi qoraish in abbasia',
  //     name: 'سمير الغالي',
  //     status: "Closed",
  //     rate: 4.5,
  //     cityEn: 'nasr'),
  // Salon(
  //     latLng: LatLng(30.130025204672926, 31.268970742821693),
  //     image: 'assets/images/5.jpg',
  //     address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
  //     name: 'Good salon',
  //     status: "Closed",
  //     rate: 4.5),
  // Salon(
  //     latLng: LatLng(30.138406328553632, 31.278630048036575),
  //     image: 'assets/images/6.jpg',
  //     address: 'You are foolish gedn',
  //     name: 'Fady adalat',
  //     status: "Open",
  //     rate: 4.5),
];
