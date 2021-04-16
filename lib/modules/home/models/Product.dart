import 'package:flutter/cupertino.dart';

class Prodcut {
  final String productName;
  final String productId;
  final String productImage;
  final double productPrice;
  final int productQuantity;
  bool available = true;

  Prodcut(
      {@required this.productName,
      @required this.productId,
      @required this.productImage,
      @required this.productPrice,
      @required this.productQuantity});
}

List<Prodcut> products = [
  Prodcut(
      productName: 'Shampoo',
      productId: DateTime.now().toIso8601String(),
      productImage: 'shampoo1.jpg',
      productPrice: 200,
      productQuantity: 2),
  Prodcut(
      productName: 'Shampoo gamed',
      productId: DateTime.now().toIso8601String(),
      productImage: 'shampoo2.jpg',
      productPrice: 400,
      productQuantity: 1),
  Prodcut(
      productName: 'Shampoo abo ahmed',
      productId: DateTime.now().toIso8601String(),
      productImage: 'shampoo4.jpg',
      productPrice: 600,
      productQuantity: 1),
];
