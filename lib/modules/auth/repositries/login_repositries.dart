class LoginRepositry {
  String id;
  String name;
  String phone;
  String email;
  String image;
  String cover;
  String gender;

  LoginRepositry({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.image,
    this.cover,
    this.gender,
  });

  factory LoginRepositry.fromJson(Map<String, dynamic> data) {
    return LoginRepositry(
        id: data['id'].toString(),
        name: data['name'],
        phone: data['phone'],
        email: data['email'],
        image: data['image'],
        gender: data['gender'],
        cover: data['cover']);
  }
}
