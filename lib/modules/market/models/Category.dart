class Category {
  final int id;
  final String nameAr;
  final String nameEn;
  final String imageName;

  Category({this.id, this.nameAr, this.imageName, this.nameEn});
  factory Category.fromjson(Map<String, dynamic> data) {
    return Category(
      id: data['id'],
      imageName: data['image'],
      nameAr: data['name_ar'],
      nameEn: data['name_en'],
    );
  }
}
