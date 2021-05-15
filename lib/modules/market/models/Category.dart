class Category {
  final int id;
  final String nameAr;
  final String nameEn;
  final String imageName;

  Category({this.id, this.nameAr, this.imageName, this.nameEn});
  factory Category.fromjson(Map<String,dynamic>data) {
    return Category(id: data['id'],
    imageName: data['image'],
    nameAr: data['name_ar'],
    nameEn: data['name_en'],
    );
    
  }
}

List<Category> categories = [
  Category(
      id: 1,
      // name: 'عناية بالشعر',
      nameAr: 'Hair care',
      imageName: 'hairstyle'),
  Category(
      id: 2,
      // name: 'مجفف شعر',
      nameAr: 'Hair dryer',
      imageName: 'hair-dryer'),
  Category(
      id:3,
      // name: 'اكسسوار شعر',
      nameAr: 'Hair Accessories',
      imageName: 'headband'),
  Category(
      id: 4,
      // name: 'عناية بالبشرة',
      nameAr: 'Skin care',
      imageName: 'shower-gel'),
  Category(
      id: 5,
      // name: 'منتجات الكيرلي',
      nameAr: 'Curely products',
      imageName: 'person'),
  Category(
      id: 6,
      // name: 'مكواه',
      nameAr: 'hair iron',
      imageName: 'beauty-salon'),
];
