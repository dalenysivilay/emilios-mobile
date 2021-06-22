import 'package:emilios_market/providers/cart_provider.dart';
import 'package:emilios_market/screens/cart_page/components/cart_empty.dart';
import 'package:emilios_market/screens/cart_page/components/cart_full.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: CartEmpty(),
          )
        : CartFull();
  }
}
