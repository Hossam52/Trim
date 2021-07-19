import 'package:connectivity/connectivity.dart';

class CheckInternet {
  static Future<bool> check() async {
    final connection = await Connectivity().checkConnectivity();
    if (connection == ConnectivityResult.mobile)
      return true;
    else if (connection == ConnectivityResult.wifi)
      return true;
    else
      return false;
  }
}
