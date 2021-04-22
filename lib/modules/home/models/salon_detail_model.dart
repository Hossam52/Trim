/*
    'selectDateWidget': true,
    'availableDatesWidget': true,
    'servicesWidget': false,
    'offersWidget': false,

*/

import 'package:flutter/material.dart';

class SalonDetailModel {
  final bool showDateWidget;
  final bool showAvailableTimes;
  final bool showServiceWidget;
  final bool showOffersWidget;

  SalonDetailModel({
    @required this.showDateWidget,
    @required this.showAvailableTimes,
    @required this.showServiceWidget,
    @required this.showOffersWidget,
  });
}
