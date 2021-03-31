import 'package:flutter/foundation.dart';

class LoginRepositry {
  String token;
  String id;
  String name;
  String phone;
  String email;
  String image;
  String cover;
  String gender;

  LoginRepositry({
    @required this.token,
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
        token: data['token'],
        id: data['user']['id'].toString(),
        name: data['user']['name'],
        phone: data['user']['phone'],
        email: data['user']['email'],
        image: data['user']['image'],
        gender: data['user']['gender'],
        cover: data['user']['cover']);
  }
}
