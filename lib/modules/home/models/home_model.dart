import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/models/salon_offer.dart';

class HomeModel {
  bool success;
  Map<String, dynamic> data;
  List<Salon> mostSearchedSalons = [];
  List<Salon> trimStars = [];
  List<SalonOffer> lastOffers = [];

  HomeModel.fromJson({Map<String, dynamic> json}) {
    success = json['success'];
    data = json['data'];
    (data['mostSearchedSalons'] as List).forEach((mostSearchedItem) {
      mostSearchedSalons.add(
        Salon.fromJson(json: mostSearchedItem),
      );
    });

    (data['trimStars'] as List).forEach(
      (trimStar) => trimStars.add(
        Salon.fromTrimStarJson(json: trimStar),
      ),
    );

    (data['lastOffers'] as List).forEach(
      (offer) => lastOffers.add(
        SalonOffer.fromJson(json: offer),
      ),
    );
  }
}
