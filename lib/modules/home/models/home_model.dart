import 'package:trim/modules/home/models/Salon.dart';
import 'package:trim/modules/home/models/salon_offer.dart';
import 'package:trim/modules/home/models/trim_star_model.dart';

class HomeModel {
  bool success;
  Map<String, dynamic> data;
  List<Salon> mostSearchedSalons;
  List<TrimStarModel> trimStars;
  List<SalonOffer> lastOffers;

  HomeModel.fromJson({Map<String, dynamic> json}) {
    success = json['success'];
    data = json['data'];
    (data['mostSearchedSalons'] as List).map(
      (mostSearchedItem) => mostSearchedSalons.add(
        Salon.fromJson(json: mostSearchedItem),
      ),
    );
  }
}
