import 'package:flutter/cupertino.dart';
import 'package:trim/modules/market/models/Category.dart';

class Product {
  final String nameAr;
  final String nameEn;
  final int productId;
  final String productImage;
  final String productPrice;
  final String productQuantity;
  final int categoryId;
  bool available = true;
  factory Product.fromjson(Map<String, dynamic> data) {
    return Product(
        // categoryId: data['id'],
        nameAr: data['name_ar'],
        nameEn: data['name_en'],
        productId: data['id'],
        productImage: data['image'],
        productPrice: data['price'].toString(),
        productQuantity: data['qty']);
  }

  Product(
      {this.categoryId,
      @required this.nameAr,
      @required this.nameEn,
      @required this.productId,
      @required this.productImage,
      @required this.productPrice,
      @required this.productQuantity});
}

List<Product> products = [
  // Product(
  //     categoryId: categories[0].id,
  //     productName: 'Shampoo',
  //     productId: 1,
  //     productImage: 'shampoo1.jpg',
  //     productPrice: 200,
  //     productQuantity: 2),
  // Product(
  //     categoryId: categories[1].id,
  //     productName: 'dryer 1',
  //     productId: 2,
  //     productImage: 'shampoo2.jpg',
  //     productPrice: 400,
  //     productQuantity: 1),
  // Product(
  //     categoryId: categories[2].id,
  //     productName: 'Toka',
  //     productId: 3,
  //     productImage: 'shampoo4.jpg',
  //     productPrice: 600,
  //     productQuantity: 1),
  // Product(
  //     categoryId: categories[3].id,
  //     productName: 'Marham lelwesh',
  //     productId: 4,
  //     productImage: '1.jpg',
  //     productPrice: 200,
  //     productQuantity: 2),
  // Product(
  //     categoryId: categories[1].id,
  //     productName: 'Shampoo gamed',
  //     productId: 5,
  //     productImage: '2.jpg',
  //     productPrice: 400,
  //     productQuantity: 1),
  // Product(
  //     categoryId: categories[3].id,
  //     productName: 'body lution',
  //     productId: 6,
  //     productImage: '3.jpg',
  //     productPrice: 600,
  //     productQuantity: 1),
  // Product(
  //     categoryId: categories[2].id,
  //     productName: 'Astek',
  //     productId: 7,
  //     productImage: '4.jpg',
  //     productPrice: 200,
  //     productQuantity: 2),
  // Product(
  //     categoryId: categories[5].id,
  //     productName: 'iron',
  //     productId: 8,
  //     productImage: '5.jpg',
  //     productPrice: 400,
  //     productQuantity: 1),
  // Product(
  //     categoryId: categories[0].id,
  //     productName: 'Shampoo abo ahmed',
  //     productId: 9,
  //     productImage: '6.jpg',
  //     productPrice: 600,
  //     productQuantity: 1),
];
