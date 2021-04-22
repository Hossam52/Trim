import 'package:google_maps_flutter/google_maps_flutter.dart';

class Salon {
  List<DateTime> availableDatas = [];
  final String imagePath;
  final String salonName;
  final String salonLocation;
  final String startTime;
  final String endTime;
  final String address;
  final LatLng latLng;
  double salonRate;
  bool isOpen;
  bool isFavorite;
  Salon(
      {this.latLng,
      this.isFavorite,
      this.address,
      this.imagePath,
      this.salonName,
      this.salonRate,
      this.isOpen,
      this.endTime,
      this.availableDatas,
      this.salonLocation,
      this.startTime});
}

List<Salon> salonsData = [
  Salon(
      isFavorite: true,
      imagePath: 'assets/images/1.jpg',
      address: 'Ibrahime saqr, tagoa el 3 beside tawla cafee',
      salonName: 'الكسندرا صالون',
      isOpen: true,
      salonRate: 3.5,
      salonLocation: 'nasr'),
  Salon(
      isFavorite: false,
      imagePath: 'assets/images/2.jpg',
      address: 'Shoubra alkhima egypt',
      salonName: 'Bianca beauty (hair salon)',
      isOpen: true,
      salonRate: 5,
      salonLocation: 'cairo'),
  Salon(
    isFavorite: false,
    imagePath: 'assets/images/3.jpg',
    address: 'Al mhala el kobra city infront of suez canal',
    salonName: 'الكسندرا صالون',
    isOpen: false,
    salonRate: 4.5,
    salonLocation: 'cairo',
  ),
  Salon(
      isFavorite: true,
      imagePath: 'assets/images/4.jpg',
      address: 'Wadi qoraish in abbasia',
      salonName: 'الكسندرا صالون',
      isOpen: false,
      salonRate: 4.5,
      salonLocation: 'nasr'),
  Salon(
      isFavorite: true,
      imagePath: 'assets/images/5.jpg',
      address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
      salonName: 'الكسندرا صالون',
      isOpen: false,
      salonRate: 4.5),
  Salon(
      isFavorite: false,
      imagePath: 'assets/images/6.jpg',
      address: 'You are foolish gedn',
      salonName: 'الكسندرا صالون',
      isOpen: true,
      salonRate: 4.5),
  Salon(
    isFavorite: true,
    imagePath: 'assets/images/3.jpg',
    address: 'Al mhala el kobra city infront of suez canal',
    salonName: 'سعيد صالون',
    isOpen: false,
    salonRate: 4.5,
    salonLocation: 'cairo',
  ),
  Salon(
      isFavorite: false,
      imagePath: 'assets/images/4.jpg',
      address: 'المعادي الجديدة بعد تفريعة قناة السويس',
      salonName: 'سعيد حمادة',
      isOpen: false,
      salonRate: 4,
      salonLocation: 'nasr'),
  Salon(
      isFavorite: true,
      imagePath: 'assets/images/5.jpg',
      address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
      salonName: 'Salon 1',
      isOpen: false,
      salonRate: 2),
  Salon(
      isFavorite: true,
      imagePath: 'assets/images/6.jpg',
      address: 'بهتيم شبرا الخيمة كشري الخدييوي ',
      salonName: 'صالون رزق',
      isOpen: true,
      salonRate: 4.5),
  Salon(
      isFavorite: false,
      imagePath: 'assets/images/2.jpg',
      address: 'Al sharqia at nasr street infront of alabd street',
      salonName: 'What you need ',
      isOpen: true,
      salonRate: 3.5,
      salonLocation: 'nasr'),
  Salon(
      isFavorite: false,
      imagePath: 'assets/images/3.jpg',
      address: 'مدينة نصر للتعدين والاسكان امام فندم الماظة',
      salonName: 'Bianca beauty (hair salon)',
      isOpen: true,
      salonRate: 5,
      salonLocation: 'cairo'),
  Salon(
    isFavorite: true,
    imagePath: 'assets/images/1.jpg',
    address: 'Al mhala el kobra city infront of suez canal',
    salonName: 'سعيد صالون',
    isOpen: false,
    salonRate: 4.5,
    salonLocation: 'cairo',
  ),
  Salon(
      isFavorite: true,
      imagePath: 'assets/images/5.jpg',
      address: 'المعادي الجديدة بعد تفريعة قناة السويس',
      salonName: 'Donia',
      isOpen: false,
      salonRate: 4.5,
      salonLocation: 'nasr'),
  Salon(
      isFavorite: false,
      imagePath: 'assets/images/5.jpg',
      address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
      salonName: 'Salon 1',
      isOpen: false,
      salonRate: 4.5),
];

List<Salon> mostSearchSalons = [
  Salon(
      imagePath: 'assets/images/1.jpg',
      address: 'Al sharqia at nasr street infront of alabd street',
      salonName: 'Beauty salon',
      isOpen: true,
      salonRate: 3.5,
      salonLocation: 'nasr'),
  Salon(
      imagePath: 'assets/images/2.jpg',
      address: 'مدينة نصر للتعدين والاسكان امام فندم الماظة',
      salonName: 'Bianca beauty (hair salon)',
      isOpen: true,
      salonRate: 5,
      salonLocation: 'cairo'),
  Salon(
    imagePath: 'assets/images/3.jpg',
    address: 'Al mhala el kobra city infront of suez canal',
    salonName: 'سعيد صالون',
    isOpen: false,
    salonRate: 4.5,
    salonLocation: 'cairo',
  ),
  Salon(
      imagePath: 'assets/images/4.jpg',
      address: 'المعادي الجديدة بعد تفريعة قناة السويس',
      salonName: 'سعيد حمادة',
      isOpen: false,
      salonRate: 4.5,
      salonLocation: 'nasr'),
  Salon(
      imagePath: 'assets/images/5.jpg',
      address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
      salonName: 'Salon 1',
      isOpen: false,
      salonRate: 4.5),
  Salon(
      imagePath: 'assets/images/6.jpg',
      address: 'بهتيم شبرا الخيمة كشري الخدييوي ',
      salonName: 'صالون رزق',
      isOpen: true,
      salonRate: 4.5),
  Salon(
      imagePath: 'assets/images/2.jpg',
      address: 'Al sharqia at nasr street infront of alabd street',
      salonName: 'What you need ',
      isOpen: true,
      salonRate: 3.5,
      salonLocation: 'nasr'),
  Salon(
      imagePath: 'assets/images/3.jpg',
      address: 'مدينة نصر للتعدين والاسكان امام فندم الماظة',
      salonName: 'Bianca beauty (hair salon)',
      isOpen: true,
      salonRate: 5,
      salonLocation: 'cairo'),
  Salon(
    imagePath: 'assets/images/1.jpg',
    address: 'Al mhala el kobra city infront of suez canal',
    salonName: 'سعيد صالون',
    isOpen: false,
    salonRate: 4.5,
    salonLocation: 'cairo',
  ),
  Salon(
      imagePath: 'assets/images/5.jpg',
      address: 'المعادي الجديدة بعد تفريعة قناة السويس',
      salonName: 'Donia',
      isOpen: false,
      salonRate: 4.5,
      salonLocation: 'nasr'),
  Salon(
      imagePath: 'assets/images/5.jpg',
      address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
      salonName: 'Salon 1',
      isOpen: false,
      salonRate: 4.5),
  Salon(
      imagePath: 'assets/images/2.jpg',
      address: 'بهتيم شبرا الخيمة كشري الخدييوي ',
      salonName: 'صالون رزق',
      isOpen: true,
      salonRate: 4.5),
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
      imagePath: 'assets/images/1.jpg',
      address: 'Ibrahime saqr, tagoa el 3 beside tawla cafee',
      salonName: 'الكسندرا صالون',
      isOpen: true,
      salonRate: 3.5,
      salonLocation: 'nasr'),
  Salon(
      latLng: LatLng(30.132346728940966, 31.274213790893555),
      imagePath: 'assets/images/2.jpg',
      address: 'Shoubra alkhima egypt',
      salonName: 'Bianca beauty (hair salon)',
      isOpen: true,
      salonRate: 5,
      salonLocation: 'cairo'),
  Salon(
    latLng: LatLng(30.130133075858343, 31.273340061306953),
    imagePath: 'assets/images/3.jpg',
    address: 'Al mhala el kobra city infront of suez canal',
    salonName: 'فتحي الحلاق',
    isOpen: false,
    salonRate: 4.5,
    salonLocation: 'cairo',
  ),
  Salon(
      latLng: LatLng(30.135126338811588, 31.268736720085144),
      imagePath: 'assets/images/4.jpg',
      address: 'Wadi qoraish in abbasia',
      salonName: 'سمير الغالي',
      isOpen: false,
      salonRate: 4.5,
      salonLocation: 'nasr'),
  Salon(
      latLng: LatLng(30.130025204672926, 31.268970742821693),
      imagePath: 'assets/images/5.jpg',
      address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
      salonName: 'Good salon',
      isOpen: false,
      salonRate: 4.5),
  Salon(
      latLng: LatLng(30.138406328553632, 31.278630048036575),
      imagePath: 'assets/images/6.jpg',
      address: 'You are foolish gedn',
      salonName: 'Fady adalat',
      isOpen: true,
      salonRate: 4.5),
];
