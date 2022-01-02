import 'package:emilios_grocery/providers/cart_provider.dart';
import 'package:emilios_grocery/screens/cart_page/components/cart_empty.dart';
import 'package:emilios_grocery/screens/cart_page/components/cart_full.dart';
import 'package:emilios_grocery/widgets/action_bar.dart';
import 'package:emilios_grocery/widgets/checkout_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  static const routeName = '/CartPage';

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartItems.isEmpty
        // Cart is Empty
        ? Container(
            child: Scaffold(
              body: Stack(
                children: [
                  CartEmpty(),
                  ActionBar(
                    title: "Cart",
                    hasBackArrow: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )
        // Cart is Full
        : Container(
            child: Scaffold(
              body: Stack(
                children: [
                  ListView.builder(
                    padding: EdgeInsets.only(top: 140.0, bottom: 0),
                    itemCount: cartProvider.getCartItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider.value(
                        value: cartProvider.getCartItems.values.toList()[index],
                        child: CartFull(
                          productId:
                              cartProvider.getCartItems.keys.toList()[index],
                        ),
                      );
                    },
                  ),
                  CheckoutSection(
                    subTotal: cartProvider.subtotalAmount,
                    taxAmount: cartProvider.taxAmount,
                    totalAmount: cartProvider.totalAmount,
                  ),
                  ActionBar(
                    title: "Cart",
                    hasBackArrow: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          );
  }
}
