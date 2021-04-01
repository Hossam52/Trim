class Salon {
  final String imagePath;
  final String salonName;
  final String startTime;
  final String endTime;
  List<DateTime> availableDatas = [];
  double salonRate;
  bool salonStatus;
  Salon(
      {this.imagePath,
      this.salonName,
      this.salonRate,
      this.salonStatus,
      this.endTime,
      this.availableDatas,
      this.startTime});
}

List<Salon> salonsData = [
  Salon(
      imagePath: '1',
      salonName: 'الكسندرا صالون',
      salonStatus: true,
      salonRate: 4.5),
  Salon(
      imagePath: '2',
      salonName: 'Bianca beauty (hair salon)',
      salonStatus: true,
      salonRate: 4.5),
  Salon(
      imagePath: '3',
      salonName: 'الكسندرا صالون',
      salonStatus: false,
      salonRate: 4.5),
  Salon(
      imagePath: '4',
      salonName: 'الكسندرا صالون',
      salonStatus: false,
      salonRate: 4.5),
];
