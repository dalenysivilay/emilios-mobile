import 'package:flutter/cupertino.dart';

class CartModel with ChangeNotifier {
  final String id;
  final String name;
  final String meats;
  final int quantity;
  final double price;
  final String images;

  CartModel({
    this.id,
    this.name,
    this.meats,
    this.price,
    this.quantity,
    this.images,
  });
}
