import 'package:emilios_market/models/cart_model.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  double get subtotalAmount {
    var total = 0.0;
    _cartItems.forEach(
      (key, value) {
        total += value.price * value.quantity;
      },
    );
    return total;
  }

  double get taxAmount {
    var taxes = 0.0;
    taxes = subtotalAmount * 0.07;
    return taxes;
  }

  double get totalAmount {
    var totalAmount = 0.0;
    totalAmount = subtotalAmount + taxAmount;
    return totalAmount;
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
                quantity: existingCartItem.quantity + 1,
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

  void reduceItemByOne(
      String productId, double price, String title, String imageUrl) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (exitingCartItem) => CartModel(
              id: exitingCartItem.id,
              name: exitingCartItem.name,
              price: exitingCartItem.price,
              quantity: exitingCartItem.quantity - 1,
              images: exitingCartItem.images));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
