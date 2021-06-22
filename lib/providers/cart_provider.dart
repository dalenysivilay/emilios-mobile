import 'package:emilios_market/models/cart_model.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach(
      (key, value) {
        total += value.price * value.quantity;
      },
    );
    return total;
  }

  void addProductToCart(
      String productId, String name, double price, String images) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (existingCartItem) => CartModel(
                id: existingCartItem.id,
                name: existingCartItem.name,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity,
                images: existingCartItem.images,
              ));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => CartModel(
                id: DateTime.now().toString(),
                name: name,
                price: price,
                quantity: 1,
                images: images,
              ));
    }
    notifyListeners();
  }
}
