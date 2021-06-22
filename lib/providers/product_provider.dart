import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emilios_market/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return _products;
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productsSnapshot) {
      _products = [];
      productsSnapshot.docs.map((element) {
        _products.insert(
          0,
          Product(
            name: element.get('name'),
            desc: element.get('desc'),
            images: element.get('images'),
            price: element.get('price'),
          ),
        );
      }).toList();
    });
  }
/*
List<Product> _products = [
    Product(
      name: "Taco",
      meats: "Al Pastor",
      price: 1.89,
      desc:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam purus.",
      images:
          "https://firebasestorage.googleapis.com/v0/b/emilios-market.appspot.com/o/photo-1514843319620-4f042827c481.jfif?alt=media&token=f723e50d-7528-4ddb-9d54-65d05c66d0cb",
    ),
  ];
 */
}
