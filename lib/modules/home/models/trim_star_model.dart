class TrimStarModel {
  int id;
  String name;
  String image;
  String cover;
  double rate;
  TrimStarModel({
    this.id,
    this.name,
    this.image,
    this.cover,
    this.rate,
  });

  factory TrimStarModel.fromJson(Map<String, dynamic> json) {
    return TrimStarModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      cover: json['cover'],
      rate: (json['rate'] as int).toDouble(),
    );
  }
}
