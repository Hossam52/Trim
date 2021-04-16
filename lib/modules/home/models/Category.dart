class Category {
  final String id;
  final String name;
  final String imageName;

  Category({this.id, this.name, this.imageName});
}

List<Category> categories = [
  Category(
      id: DateTime.now().toIso8601String(),
      name: 'عناية بالشعر',
      imageName: 'hairstyle'),
  Category(
      id: DateTime.now().toIso8601String(),
      name: 'مجفف شعر',
      imageName: 'hair-dryer'),
  Category(
      id: DateTime.now().toIso8601String(),
      name: 'اكسسوار شعر',
      imageName: 'headband'),
  Category(
      id: DateTime.now().toIso8601String(),
      name: 'عناية بالبشرة',
      imageName: 'shower-gel'),
  Category(
      id: DateTime.now().toIso8601String(),
      name: 'منتجات الكيرلي',
      imageName: 'person'),
  Category(
      id: DateTime.now().toIso8601String(),
      name: 'مكواه',
      imageName: 'beauty-salon'),
];
