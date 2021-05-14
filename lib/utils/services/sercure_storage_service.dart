/*We do not store user credentials, API tokens, secret API keys in local storage, for that we make use of flutter_secure_storage which stores data in the Android Keystore and Apple keychain with platform-specific encryption technique.
In this file, there will be getters and setters for each and every data to be stored in platform secure storage.*/

import 'package:shared_preferences/shared_preferences.dart';

class TrimShared {
  static String token;
  static void saveDataToShared(String key, String value) async {
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
}
