import 'package:emilios_grocery/providers/cart_provider.dart';
import 'package:emilios_grocery/screens/cart_page/components/cart_empty.dart';
import 'package:emilios_grocery/screens/cart_page/components/cart_full.dart';
import 'package:emilios_grocery/widgets/action_bar.dart';
import 'package:emilios_grocery/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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
                  checkoutSection(context, cartProvider.subtotalAmount,
                      cartProvider.taxAmount, cartProvider.totalAmount),
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

  Widget checkoutSection(
    BuildContext context,
    double subTotal,
    double taxAmount,
    double totalAmount,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 0.5),
              ),
            ],
          ),
          child: Column(
            children: [
              //Totals Row
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
                child: Column(
                  children: [
                    //Subtotal Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "\$ ${subTotal.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    //Taxes Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tax",
                          style: TextStyle(fontSize: 14.0),
                        ),
                        Text(
                          "\$ ${taxAmount.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    //Total Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          "\$ ${totalAmount.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    //Continue to Payment Button
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 24.0),
                child: RoundedButton(
                  text: "Continue to Payment",
                  onPressed: () async {
                    final paymentMethod = await Stripe.instance
                        .createPaymentMethod(PaymentMethodParams.card());
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
