class Coupoun {
  final int id;
  final String code;
  final String titleEn;
  final String titleAr;
  final String duration;
  final String price;
  final String cityEn;
  final String cityAr;
  final String governorateEn;
  final String governorateAr;
  final int usageNumberTimes;
  final String image;
  final String anywhere;
  final String moreway;
  final String oneway;
  final String oq;
  final String week;

  Coupoun(
      {
      this.id,
      this.code,
      this.titleEn,
      this.titleAr,
      this.duration,
      this.price,
      this.cityEn,
      this.cityAr,
      this.governorateEn,
      this.governorateAr,
      this.usageNumberTimes,
      this.image,
      this.anywhere,
      this.moreway,
      this.oneway,
      this.oq,
      this.week});
  factory Coupoun.fromjson(Map<String, dynamic> data) {
    return Coupoun(
        id: data['id'],
        code: data['code'],
        titleEn: data['title_en'],
        titleAr: data['title_ar'],
        duration: data['duration'],
        price: data['price'],
        cityEn: data['city_en'],
        cityAr: data['city_ar'],
        governorateEn: data['governorate_en'],
        governorateAr: data['governorate_ar'],
        usageNumberTimes: data['usage_number_times'],
        image: data['image'],
        anywhere: data['anywhere'] ,
        moreway: data['moreway'],
        oneway: data['oneway'],
        oq: data['oq'],
        week: data['week']);
  }
}
