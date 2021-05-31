/*We do not store user credentials, API tokens, secret API keys in local storage, for that we make use of flutter_secure_storage which stores data in the Android Keystore and Apple keychain with platform-specific encryption technique.
In this file, there will be getters and setters for each and every data to be stored in platform secure storage.*/

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trim/modules/auth/models/token_model.dart';

class TrimShared {
  static String token;
  static Future<void> saveDataToShared(String key, String value) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setString(key, value);
    token = value;
  }

  static Future<String> getDataFromShared(String key) async {
    final shared = await SharedPreferences.getInstance();
    return token = shared.getString(key);
  }

  static void removeFromShared(String key) async {
    final shared = await SharedPreferences.getInstance();
    if (shared.containsKey(key)) {
      await shared.remove(key);
    }
    token = null;
  }

  static Future<void> storeDeliveryData({
    @required String city,
    @required String street,
    @required String country,
    @required String phone,
  }) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setString('deliveryCity', city);
    await shared.setString('deliveryStreet', street);
    await shared.setString('deliveryCountry', country);
    await shared.setString('deliveryPhone', phone);
  }

  static Future<void> storeProfileData(TokenModel loginModel) async {
    final shared = await SharedPreferences.getInstance();
    await shared.setString('token', loginModel.token);
    await shared.setString('name', loginModel.loginModel.name);
    await shared.setString('email', loginModel.loginModel.email);
    await shared.setString('image', loginModel.loginModel.image);
    await shared.setString('cover', loginModel.loginModel.cover);
    await shared.setString('phone', loginModel.loginModel.phone);
  }

  static void removeProfileData() async {
    final shared = await SharedPreferences.getInstance();
    await shared.remove('token');
    await shared.remove('name');
    await shared.remove('email');
    await shared.remove('image');
    await shared.remove('token');
    await shared.remove('cover');
    await shared.remove('phone');
    print('Removed Data from shared prefrences');
  }
}
