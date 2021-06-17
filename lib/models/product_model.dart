import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String title;
  final String description;
  final double price;
  final String imageurl;

  Product({
    this.title,
    this.description,
    this.price,
    this.imageurl,
  });
}
