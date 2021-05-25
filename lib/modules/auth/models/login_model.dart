import 'package:flutter/foundation.dart';

class LoginModel {
  // String token;
  int id;
  String name;
  String phone;
  String email;
  String image;
  String cover;
  String gender;
  String governorateEn;
  String governorateAr;
  String cityEn;
  String cityAr;
  String birthDate;

  LoginModel({
    // @required this.token,
    this.id,
    this.name,
    this.phone,
    this.email,
    this.image,
    this.cover,
    this.gender,
    this.birthDate,
    this.cityAr,
    this.cityEn,
    this.governorateAr,
    this.governorateEn,
  });

  LoginModel.fromJson({@required Map<String, dynamic> json}) {
    // token = json['token'];
    final Map<String, dynamic> user = json['user'];
    print(user);
    if (user != null) {
      id = user['id'] ?? 0;
      name = user['name'] ?? "";
      phone = user['phone'] ?? "Unknown";
      email = user['email'] ?? "UNKNOWN";
      image = user['image'] ?? "";
      gender = user['gender'] ?? "";
      cover = user['cover'] ?? "";
      governorateEn = user['governorate_en'] ?? "";
      governorateAr = user['governorate_ar'] ?? "";
      cityEn = user['city_en'] ?? "";
      cityAr = user['city_ar'] ?? "";
      birthDate = user['birth_date'] ?? "";
    }
  }
}
