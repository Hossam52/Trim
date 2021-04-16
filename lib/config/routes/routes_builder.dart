import 'package:flutter/material.dart';
import 'package:trim/modules/auth/screens/forgot_password_screen.dart';
import 'package:trim/modules/auth/screens/verification_code_screen.dart';
import 'package:trim/modules/home/screens/BadgeScreen.dart';
import 'package:trim/modules/home/screens/CategoryProductsScreen.dart';
import 'package:trim/modules/home/screens/ReservationDetailsScreen.dart';
import 'package:trim/modules/home/screens/ReservationsScreen.dart';
import 'package:trim/modules/home/screens/TrimStarReservationScreen.dart';
import 'package:trim/modules/home/screens/salon_detail_screen.dart';
import 'package:trim/modules/home/screens/time_selection_screen.dart';
import 'package:trim/modules/home/screens/trimStars_Screen.dart';
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
  TrimStarReservationScreen.routeName: (_) => TrimStarReservationScreen(),
  CategoryProductsScreen.routeName: (_) => CategoryProductsScreen(),
  ReservationsScreen.routeName: (_) => ReservationsScreen(),
  ReservationDetailsScreen.routeName: (_) => ReservationDetailsScreen(),
  BadgeScrren.routeName: (_) => BadgeScrren(),
};
