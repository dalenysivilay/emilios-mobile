import 'package:emilios_market/models/cart_model.dart';
import 'package:emilios_market/providers/cart_provider.dart';
import 'package:emilios_market/screens/cart_page/components/cart_empty.dart';
import 'package:emilios_market/screens/cart_page/components/cart_full.dart';
import 'package:emilios_market/widgets/action_bar.dart';
import 'package:emilios_market/widgets/rounded_button.dart';
import 'package:emilios_market/services/payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  void payWithCard({int amount}) async {
    CircularProgressIndicator();
    var response = await StripeService.payWithNewCard(
        currency: 'USD', amount: amount.toString());
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(response.message),
        duration:
            Duration(milliseconds: response.success == true ? 1200 : 3000)));
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartItems.isEmpty
        ? SafeArea(
            child: Stack(
              children: [
                Scaffold(
                  body: CartEmpty(),
                ),
                ActionBar(title: "YOUR BAG"),
              ],
            ),
          )
        : SafeArea(
            child: Stack(
              children: [
                Scaffold(
                  body: ListView.builder(
                    padding: EdgeInsets.only(top: 100.0, bottom: 0),
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
                ),
                checkoutSection(context, cartProvider.subtotalAmount,
                    cartProvider.taxAmount, cartProvider.totalAmount),
                ActionBar(
                  title: "YOUR BAG",
                  hasBackArrow: false,
                ),
              ],
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
          color: Colors.white,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RoundedButton(
                          text: "Continue to Payment",
                          onPressed: () {
                            double amountInCents = totalAmount * 1000;
                            int integerAmount = (amountInCents / 10).ceil();
                            payWithCard(amount: integerAmount);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
