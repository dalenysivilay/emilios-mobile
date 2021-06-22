import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String name;
  final String desc;
  final double price;
  final String images;

  Product({
    this.name,
    this.desc,
    this.price,
    this.images,
  });
}