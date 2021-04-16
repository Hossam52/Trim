import 'package:flutter/material.dart';
import 'package:trim/modules/auth/screens/forgot_password_screen.dart';
import 'package:trim/modules/auth/screens/personal_detail_screen.dart';
import 'package:trim/modules/auth/screens/verification_code_screen.dart';
import 'package:trim/modules/home/screens/favourties_screen.dart';
import 'package:trim/modules/home/screens/reserve_screen.dart';
import 'package:trim/modules/settings/screens/coupons_screen.dart';
import 'package:trim/modules/home/screens/direction_map_screen.dart';
import 'package:trim/modules/home/screens/map_screen.dart';
import 'package:trim/modules/home/screens/CategoryProductsScreen.dart';
import 'package:trim/modules/home/screens/TrimStarReservationScreen.dart';
import 'package:trim/modules/home/screens/salon_detail_screen.dart';
import 'package:trim/modules/home/screens/time_selection_screen.dart';
import 'package:trim/modules/home/screens/trimStars_Screen.dart';
import 'package:trim/modules/settings/screens/customer_serviceScreen.dart';
import 'package:trim/modules/settings/screens/notifications_screen.dart';
import 'package:trim/modules/settings/screens/wallet_screen.dart';
import '../../modules/auth/screens/registration_screen.dart';
import '../../modules/auth/screens/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (_) => LoginScreen(),
  RegistrationScreen.routeName: (_) => RegistrationScreen(),
  VerificationCodeScreen.routeName: (_) => VerificationCodeScreen(),
  ForgotPassword.routeName: (_) => ForgotPassword(),
  SalonDetailScreen.routeName: (_) => SalonDetailScreen(),
  TimeSelectionScreen.routeName: (_) => TimeSelectionScreen(),
  TrimStarsScreen.routeName: (_) => TrimStarsScreen(),
  MapScreen.routeName: (_) => MapScreen(),
  TrimStarReservationScreen.routeName: (_) => TrimStarReservationScreen(),
  CategoryProductsScreen.routeName: (_) => CategoryProductsScreen(),
  DirectionMapScreen.routeName: (_) => DirectionMapScreen(),
  PersonDetailScreen.routeName: (_) => PersonDetailScreen(),
  CouponsScreen.routeName: (_) => CouponsScreen(),
  WalletScreen.routeName: (_) => WalletScreen(),
  CustomerServiceScreen.routeName: (_) => CustomerServiceScreen(),
  NotificationScreen.routeName: (_) => NotificationScreen(),
  ReserveScreen.routeName: (_) => ReserveScreen(),
  FavouritesScreen.routeName: (_) => FavouritesScreen(),
};
