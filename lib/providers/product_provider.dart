import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emilios_market/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  Product _currentProduct;

  List<Product> get products {
    return _products;
  }

  Product get currentProduct => _currentProduct;

  set currentProduct(Product product) {
    _currentProduct = product;
    notifyListeners();
  }

  Product findById(String productId) {
    return _products.firstWhere((element) => element.id == productId);
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
            id: element.get('id'),
            name: element.get('name'),
            desc: element.get('desc'),
            meats: element.get('meats'),
            images: element.get('images'),
            price: element.get('price'),
          ),
        );
      }).toList();
    });
  }
}
