import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String desc;
  final List meats;
  final double price;
  final String images;

  Product({
    this.id,
    this.name,
    this.desc,
    this.meats,
    this.price,
    this.images,
  });
}
