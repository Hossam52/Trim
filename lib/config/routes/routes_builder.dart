import 'package:flutter/material.dart';
import 'package:trim/modules/auth/screens/forgot_password_screen.dart';
import 'package:trim/modules/auth/screens/personal_detail_screen.dart';
import 'package:trim/modules/auth/screens/verification_code_screen.dart';
import 'package:trim/modules/home/screens/home_Screen.dart';
import 'package:trim/modules/market/screens/BadgeScreen.dart';
import 'package:trim/modules/home/screens/Salons_Screen.dart';
import 'package:trim/modules/payment/screens/confirm_order_screen.dart';
import 'package:trim/modules/reservation/screens/modify_salon_order.dart';
import 'package:trim/modules/settings/screens/favourties_screen.dart';
import 'package:trim/modules/home/screens/reserve_screen.dart';
import 'package:trim/modules/settings/screens/coupons_screen.dart';
import 'package:trim/modules/home/screens/direction_map_screen.dart';
import 'package:trim/modules/home/screens/map_screen.dart';
import 'package:trim/modules/market/screens/CategoryProductsScreen.dart';
import 'package:trim/modules/reservation/screens/ReservationDetailsScreen.dart';
import 'package:trim/modules/reservation/screens/ReservationsScreen.dart';
import 'package:trim/modules/home/screens/details_screen.dart';
import 'package:trim/modules/home/screens/raters_screen.dart';
import 'package:trim/modules/settings/screens/customer_serviceScreen.dart';
import 'package:trim/modules/settings/screens/notifications_screen.dart';
import 'package:trim/modules/settings/screens/wallet_screen.dart';
import '../../modules/auth/screens/registration_screen.dart';
import '../../modules/auth/screens/login_screen.dart';
import '../../modules/payment/screens/payment_detail_screen.dart';
import '../../modules/payment/screens/payment_methods_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (_) => LoginScreen(),
  RegistrationScreen.routeName: (_) => RegistrationScreen(),
  VerificationCodeScreen.routeName: (_) => VerificationCodeScreen(),
  ForgotPassword.routeName: (_) => ForgotPassword(),
  HomeScreen.routeName: (_) => HomeScreen(),
  DetailsScreen.routeName: (_) => DetailsScreen(),
  RatersScreen.routeName: (_) => RatersScreen(),
  MapScreen.routeName: (_) => MapScreen(),
  CategoryProductsScreen.routeName: (_) => CategoryProductsScreen(),
  ReservationsScreen.routeName: (_) => ReservationsScreen(),
  ReservationDetailsScreen.routeName: (_) => ReservationDetailsScreen(),
  BadgeScrren.routeName: (_) => BadgeScrren(),
  DirectionMapScreen.routeName: (_) => DirectionMapScreen(),
  PersonDetailScreen.routeName: (_) => PersonDetailScreen(),
  CouponsScreen.routeName: (_) => CouponsScreen(),
  WalletScreen.routeName: (_) => WalletScreen(),
  CustomerServiceScreen.routeName: (_) => CustomerServiceScreen(),
  NotificationScreen.routeName: (_) => NotificationScreen(),
  ReserveScreen.routeName: (_) => ReserveScreen(),
  FavouritesScreen.routeName: (_) => FavouritesScreen(),
  SalonsScreen.routeName: (_) => SalonsScreen(),
  ConfirmOrderScreen.routeName: (_) => ConfirmOrderScreen(),
  PaymentDetailScreen.routeName: (_) => PaymentDetailScreen(),
  PaymentMethodsScreen.routeName: (_) => PaymentMethodsScreen(),
  ModifySalonOrder.routeName: (_) => ModifySalonOrder(),
};
