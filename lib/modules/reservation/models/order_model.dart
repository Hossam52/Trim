import 'dart:developer';

import 'package:trim/modules/home/models/salon_offer.dart';
import 'package:trim/modules/home/models/salon_service.dart';
import 'package:trim/modules/market/models/Product.dart';

class OrderModel {
  int id;
  String lat;
  String lng;
  String userId;
  String userName;
  String barberId;
  String barberName;
  String statusId;
  String statusAr;
  String statusEn;
  String cancelReason;
  String approve;
  String rate;
  String review;
  String reviewImage;
  String paymentMethod;
  String paymentCoupon;
  String phone;
  String address;
  String isNow;
  String type;
  String workDayId;
  String cost;
  String discount;
  String total;
  String reservationTime;
  String reservationDay;
  String createdAt;
  List<SalonService> services;
  List<SalonOffer> offers;
  List<Product> products;

  OrderModel(
      {this.id,
      this.lat,
      this.lng,
      this.userId,
      this.userName,
      this.barberId,
      this.barberName,
      this.statusId,
      this.statusAr,
      this.statusEn,
      this.cancelReason,
      this.approve,
      this.rate,
      this.review,
      this.reviewImage,
      this.paymentMethod,
      this.paymentCoupon,
      this.phone,
      this.address,
      this.isNow,
      this.type,
      this.workDayId,
      this.cost,
      this.discount,
      this.total,
      this.reservationTime,
      this.reservationDay,
      this.createdAt,
      this.services,
      this.offers,
      this.products});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lat = json['lat'];
    lng = json['lng'];
    userId = json['user_id'];
    userName = json['user_name'];
    barberId = json['barber_id'];
    barberName = json['barber_name'];
    statusId = json['status_id'];
    statusAr = json['status_ar'];
    statusEn = json['status_en'];
    cancelReason = json['cancel_reason'];
    approve = json['approve'];
    rate = json['rate'];
    review = json['review'];
    reviewImage = json['review_image'];
    paymentMethod = json['payment_method'];
    paymentCoupon = json['payment_coupon'];
    phone = json['phone'];
    address = json['address'];
    isNow = json['is_now'];
    type = json['type'];
    workDayId = json['work_day_id'];
    cost = json['cost'];
    discount = json['discount'];
    total = json['total'];
    reservationTime = json['reservation_time'];
    reservationDay = json['reservation_day'];
    createdAt = json['created_at'];
    if (json['services'] != null) {
      services = [];
      json['services'].forEach((service) {
        services.add(new SalonService.fromJson(service));
      });
    }
    if (json['offers'] != null) {
      offers = [];
      json['offers'].forEach((offer) {
        offers.add(SalonOffer.fromJson(json: offer));
      });
    }
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((product) {
        products.add(Product.fromjson(product));
      });
    }
  }
}
