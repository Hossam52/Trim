import 'package:flutter/cupertino.dart';
import 'package:trim/modules/market/models/Category.dart';

class Prodcut {
  final String productName;
  final String productId;
  final String productImage;
  final double productPrice;
  final int productQuantity;
  final String categoryId;
  bool available = true;

  Prodcut(
      {@required this.categoryId,
      @required this.productName,
      @required this.productId,
      @required this.productImage,
      @required this.productPrice,
      @required this.productQuantity});
}

List<Prodcut> products = [
  Prodcut(
      categoryId: categories[0].id,
      productName: 'Shampoo',
      productId: DateTime.now().toIso8601String(),
      productImage: 'shampoo1.jpg',
      productPrice: 200,
      productQuantity: 2),
  Prodcut(
      categoryId: categories[1].id,
      productName: 'dryer 1',
      productId: DateTime.now().toIso8601String(),
      productImage: 'shampoo2.jpg',
      productPrice: 400,
      productQuantity: 1),
  Prodcut(
      categoryId: categories[2].id,
      productName: 'Toka',
      productId: DateTime.now().toIso8601String(),
      productImage: 'shampoo4.jpg',
      productPrice: 600,
      productQuantity: 1),
  Prodcut(
      categoryId: categories[3].id,
      productName: 'Marham lelwesh',
      productId: DateTime.now().toIso8601String(),
      productImage: '1.jpg',
      productPrice: 200,
      productQuantity: 2),
  Prodcut(
      categoryId: categories[1].id,
      productName: 'Shampoo gamed',
      productId: DateTime.now().toIso8601String(),
      productImage: '2.jpg',
      productPrice: 400,
      productQuantity: 1),
  Prodcut(
      categoryId: categories[3].id,
      productName: 'body lution',
      productId: DateTime.now().toIso8601String(),
      productImage: '3.jpg',
      productPrice: 600,
      productQuantity: 1),
  Prodcut(
      categoryId: categories[2].id,
      productName: 'Astek',
      productId: DateTime.now().toIso8601String(),
      productImage: '4.jpg',
      productPrice: 200,
      productQuantity: 2),
  Prodcut(
      categoryId: categories[5].id,
      productName: 'iron',
      productId: DateTime.now().toIso8601String(),
      productImage: '5.jpg',
      productPrice: 400,
      productQuantity: 1),
  Prodcut(
      categoryId: categories[0].id,
      productName: 'Shampoo abo ahmed',
      productId: DateTime.now().toIso8601String(),
      productImage: '6.jpg',
      productPrice: 600,
      productQuantity: 1),
];
