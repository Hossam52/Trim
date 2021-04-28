import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  String commentsCount;
  String address;
  String latitude;
  String longitude;
  LatLng latLng;
  bool status;
  String openFrom;
  String openTo;
  bool isFavorite;
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
      this.latitude,
      this.longitude,
      this.latLng,
      this.isFavorite,
      this.address,
      this.image,
      this.name,
      this.rate,
      this.status,
      this.openTo,
      this.availableDatas,
      this.openFrom});

  factory Salon.fromJson({Map<String, dynamic> json}) {
    return Salon(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      governorateEn: json['governorate_en'],
      governorateAr: json['governorate_ar'],
      cityEn: json['city_en'],
      cityAr: json['city_ar'],
      commentsCount: json['commentsCount'],
      latitude: json['lat'],
      longitude: json['lang'],
      isFavorite: json['is_fav'],
      address: json['address'],
      image: json['image'],
      name: json['name'],
      rate: json['rate'],
      status: json['status'],
      openTo: json['to'],
      openFrom: json['from'],
    );
  }
}

List<Salon> salonsData = [
  Salon(
      isFavorite: true,
      image: 'assets/images/1.jpg',
      address: 'Ibrahime saqr, tagoa el 3 beside tawla cafee',
      name: 'الكسندرا صالون',
      status: true,
      rate: 3.5,
      cityEn: 'nasr'),
  Salon(
      isFavorite: false,
      image: 'assets/images/2.jpg',
      address: 'Shoubra alkhima egypt',
      name: 'Bianca beauty (hair salon)',
      status: true,
      rate: 5,
      cityEn: 'cairo'),
  Salon(
    isFavorite: false,
    image: 'assets/images/3.jpg',
    address: 'Al mhala el kobra city infront of suez canal',
    name: 'الكسندرا صالون',
    status: false,
    rate: 4.5,
    cityEn: 'cairo',
  ),
  Salon(
      isFavorite: true,
      image: 'assets/images/4.jpg',
      address: 'Wadi qoraish in abbasia',
      name: 'الكسندرا صالون',
      status: false,
      rate: 4.5,
      cityEn: 'nasr'),
  Salon(
      isFavorite: true,
      image: 'assets/images/5.jpg',
      address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
      name: 'الكسندرا صالون',
      status: false,
      rate: 4.5),
  Salon(
      isFavorite: false,
      image: 'assets/images/6.jpg',
      address: 'You are foolish gedn',
      name: 'الكسندرا صالون',
      status: true,
      rate: 4.5),
  Salon(
    isFavorite: true,
    image: 'assets/images/3.jpg',
    address: 'Al mhala el kobra city infront of suez canal',
    name: 'سعيد صالون',
    status: false,
    rate: 4.5,
    cityEn: 'cairo',
  ),
  Salon(
      isFavorite: false,
      image: 'assets/images/4.jpg',
      address: 'المعادي الجديدة بعد تفريعة قناة السويس',
      name: 'سعيد حمادة',
      status: false,
      rate: 4,
      cityEn: 'nasr'),
  Salon(
      isFavorite: true,
      image: 'assets/images/5.jpg',
      address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
      name: 'Salon 1',
      status: false,
      rate: 2),
  Salon(
      isFavorite: true,
      image: 'assets/images/6.jpg',
      address: 'بهتيم شبرا الخيمة كشري الخدييوي ',
      name: 'صالون رزق',
      status: true,
      rate: 4.5),
  Salon(
      isFavorite: false,
      image: 'assets/images/2.jpg',
      address: 'Al sharqia at nasr street infront of alabd street',
      name: 'What you need ',
      status: true,
      rate: 3.5,
      cityEn: 'nasr'),
  Salon(
      isFavorite: false,
      image: 'assets/images/3.jpg',
      address: 'مدينة نصر للتعدين والاسكان امام فندم الماظة',
      name: 'Bianca beauty (hair salon)',
      status: true,
      rate: 5,
      cityEn: 'cairo'),
  Salon(
    isFavorite: true,
    image: 'assets/images/1.jpg',
    address: 'Al mhala el kobra city infront of suez canal',
    name: 'سعيد صالون',
    status: false,
    rate: 4.5,
    cityEn: 'cairo',
  ),
  Salon(
      isFavorite: true,
      image: 'assets/images/5.jpg',
      address: 'المعادي الجديدة بعد تفريعة قناة السويس',
      name: 'Donia',
      status: false,
      rate: 4.5,
      cityEn: 'nasr'),
  Salon(
      isFavorite: false,
      image: 'assets/images/5.jpg',
      address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
      name: 'Salon 1',
      status: false,
      rate: 4.5),
];

List<Salon> mostSearchSalons = [
  Salon(
      image: 'assets/images/1.jpg',
      address: 'Al sharqia at nasr street infront of alabd street',
      name: 'Beauty salon',
      status: true,
      rate: 3.5,
      cityEn: 'nasr'),
  Salon(
      image: 'assets/images/2.jpg',
      address: 'مدينة نصر للتعدين والاسكان امام فندم الماظة',
      name: 'Bianca beauty (hair salon)',
      status: true,
      rate: 5,
      cityEn: 'cairo'),
  Salon(
    image: 'assets/images/3.jpg',
    address: 'Al mhala el kobra city infront of suez canal',
    name: 'سعيد صالون',
    status: false,
    rate: 4.5,
    cityEn: 'cairo',
  ),
  Salon(
      image: 'assets/images/4.jpg',
      address: 'المعادي الجديدة بعد تفريعة قناة السويس',
      name: 'سعيد حمادة',
      status: false,
      rate: 4.5,
      cityEn: 'nasr'),
  Salon(
      image: 'assets/images/5.jpg',
      address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
      name: 'Salon 1',
      status: false,
      rate: 4.5),
  Salon(
      image: 'assets/images/6.jpg',
      address: 'بهتيم شبرا الخيمة كشري الخدييوي ',
      name: 'صالون رزق',
      status: true,
      rate: 4.5),
  Salon(
      image: 'assets/images/2.jpg',
      address: 'Al sharqia at nasr street infront of alabd street',
      name: 'What you need ',
      status: true,
      rate: 3.5,
      cityEn: 'nasr'),
  Salon(
      image: 'assets/images/3.jpg',
      address: 'مدينة نصر للتعدين والاسكان امام فندم الماظة',
      name: 'Bianca beauty (hair salon)',
      status: true,
      rate: 5,
      cityEn: 'cairo'),
  Salon(
    image: 'assets/images/1.jpg',
    address: 'Al mhala el kobra city infront of suez canal',
    name: 'سعيد صالون',
    status: false,
    rate: 4.5,
    cityEn: 'cairo',
  ),
  Salon(
      image: 'assets/images/5.jpg',
      address: 'المعادي الجديدة بعد تفريعة قناة السويس',
      name: 'Donia',
      status: false,
      rate: 4.5,
      cityEn: 'nasr'),
  Salon(
      image: 'assets/images/5.jpg',
      address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
      name: 'Salon 1',
      status: false,
      rate: 4.5),
  Salon(
      image: 'assets/images/2.jpg',
      address: 'بهتيم شبرا الخيمة كشري الخدييوي ',
      name: 'صالون رزق',
      status: true,
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
  Salon(
      latLng: LatLng(30.133912262634386, 31.273745745420456),
      image: 'assets/images/1.jpg',
      address: 'Ibrahime saqr, tagoa el 3 beside tawla cafee',
      name: 'الكسندرا صالون',
      status: true,
      rate: 3.5,
      cityEn: 'nasr'),
  Salon(
      latLng: LatLng(30.132346728940966, 31.274213790893555),
      image: 'assets/images/2.jpg',
      address: 'Shoubra alkhima egypt',
      name: 'Bianca beauty (hair salon)',
      status: true,
      rate: 5,
      cityEn: 'cairo'),
  Salon(
    latLng: LatLng(30.130133075858343, 31.273340061306953),
    image: 'assets/images/3.jpg',
    address: 'Al mhala el kobra city infront of suez canal',
    name: 'فتحي الحلاق',
    status: false,
    rate: 4.5,
    cityEn: 'cairo',
  ),
  Salon(
      latLng: LatLng(30.135126338811588, 31.268736720085144),
      image: 'assets/images/4.jpg',
      address: 'Wadi qoraish in abbasia',
      name: 'سمير الغالي',
      status: false,
      rate: 4.5,
      cityEn: 'nasr'),
  Salon(
      latLng: LatLng(30.130025204672926, 31.268970742821693),
      image: 'assets/images/5.jpg',
      address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
      name: 'Good salon',
      status: false,
      rate: 4.5),
  Salon(
      latLng: LatLng(30.138406328553632, 31.278630048036575),
      image: 'assets/images/6.jpg',
      address: 'You are foolish gedn',
      name: 'Fady adalat',
      status: true,
      rate: 4.5),
];
