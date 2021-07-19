import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SocialProfileModel {
  final User user;
  final String token;
  final photoUrl;
  SocialProfileModel({@required this.user, this.photoUrl, this.token});

  Map<String, dynamic> toMap() {
    return {
      'email': user.email,
      'provider_id': user.uid,
      'name': user.displayName,
      'provider_token': token,
      'image': photoUrl ?? user.photoURL,
    };
  }
}
