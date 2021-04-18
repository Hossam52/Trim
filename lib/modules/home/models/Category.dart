class Category {
  final String id;
  final String name;
  final String imageName;

  Category({this.id, this.name, this.imageName});
}

List<Category> categories = [
  Category(
      id: DateTime.now().toIso8601String(),
      // name: 'عناية بالشعر',
      name: 'Hair care',
      imageName: 'hairstyle'),
  Category(
      id: DateTime.now().toIso8601String(),
      // name: 'مجفف شعر',
      name: 'Hair dryer',
      imageName: 'hair-dryer'),
  Category(
      id: DateTime.now().toIso8601String(),
      // name: 'اكسسوار شعر',
      name: 'Hair Accessories',
      imageName: 'headband'),
  Category(
      id: DateTime.now().toIso8601String(),
      // name: 'عناية بالبشرة',
      name: 'Skin care',
      imageName: 'shower-gel'),
  Category(
      id: DateTime.now().toIso8601String(),
      // name: 'منتجات الكيرلي',
      name: 'Curely products',
      imageName: 'person'),
  Category(
      id: DateTime.now().toIso8601String(),
      // name: 'مكواه',
      name: 'hair iron',
      imageName: 'beauty-salon'),
];
