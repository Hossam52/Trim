class Salon {
  final String imagePath;
  final String salonName;
  final String salonLocation;
  final String startTime;
  final String endTime;
  final String address;
  List<DateTime> availableDatas = [];
  double salonRate;
  bool salonStatus;
  Salon(
      {this.address,
      this.imagePath,
      this.salonName,
      this.salonRate,
      this.salonStatus,
      this.endTime,
      this.availableDatas,
      this.salonLocation,
      this.startTime});
}

List<Salon> salonsData = [
  Salon(
      imagePath: '1',
      address: 'Ibrahime saqr, tagoa el 3 beside tawla cafee',
      salonName: 'الكسندرا صالون',
      salonStatus: true,
      salonRate: 3.5,
      salonLocation: 'nasr'),
  Salon(
      imagePath: '2',
      address: 'Shoubra alkhima egypt',
      salonName: 'Bianca beauty (hair salon)',
      salonStatus: true,
      salonRate: 5,
      salonLocation: 'cairo'),
  Salon(
    imagePath: '3',
    address: 'Al mhala el kobra city infront of suez canal',
    salonName: 'الكسندرا صالون',
    salonStatus: false,
    salonRate: 4.5,
    salonLocation: 'cairo',
  ),
  Salon(
      imagePath: '4',
      address: 'Wadi qoraish in abbasia',
      salonName: 'الكسندرا صالون',
      salonStatus: false,
      salonRate: 4.5,
      salonLocation: 'nasr'),
  Salon(
      imagePath: '5',
      address: 'Alfayoom aldakhlia shoubra matrooh south sinai alex',
      salonName: 'الكسندرا صالون',
      salonStatus: false,
      salonRate: 4.5),
  Salon(
      imagePath: '6',
      address: 'You are foolish gedn',
      salonName: 'الكسندرا صالون',
      salonStatus: true,
      salonRate: 4.5),
];

List<Salon> favouriteSalons = [
  Salon(
      imagePath: 'assets/images/4.jpg',
      salonName: 'الكسندرا صالون',
      salonStatus: false,
      salonRate: 2.5,
      salonLocation: 'nasr'),
  Salon(
      imagePath: 'assets/images/3.jpg',
      salonName: 'الكسندرا صالون',
      salonStatus: false,
      salonRate: 4.5),
  Salon(
      imagePath: 'assets/images/2.jpg',
      salonName: 'الكسندرا صالون',
      salonStatus: true,
      salonRate: 5),
  Salon(
      imagePath: 'assets/images/4.jpg',
      salonName: 'الكسندرا صالون',
      salonStatus: false,
      salonRate: 2.5,
      salonLocation: 'nasr'),
  Salon(
      imagePath: 'assets/images/3.jpg',
      salonName: 'الكسندرا صالون',
      salonStatus: false,
      salonRate: 4.5),
  Salon(
      imagePath: 'assets/images/2.jpg',
      salonName: 'الكسندرا صالون',
      salonStatus: true,
      salonRate: 5),
];
