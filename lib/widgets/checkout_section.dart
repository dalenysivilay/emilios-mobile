import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emilios_grocery/providers/cart_provider.dart';
import 'package:emilios_grocery/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CheckoutSection extends StatelessWidget {
  final double subTotal;
  final double taxAmount;
  final double totalAmount;

  const CheckoutSection({
    Key key,
    this.subTotal,
    this.taxAmount,
    this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uuid = Uuid();
    var orderSuccess = false;
    final cartProvider = Provider.of<CartProvider>(context);
    final FirebaseAuth _auth = FirebaseAuth.instance;

    Future<void> initPaymentSheet(context,
        {@required String email, @required int amount}) async {
      try {
        // 1. create payment intent on the server
        final response = await http.post(
            Uri.parse(
                'https://us-central1-emilios-grocery.cloudfunctions.net/stripePaymentIntentRequest'),
            body: {
              'email': email,
              'amount': amount.toString(),
            });

        final jsonResponse = jsonDecode(response.body);
        log(jsonResponse.toString());

        //2. initialize the payment sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: jsonResponse['paymentIntent'],
            merchantDisplayName: 'Emilios Grocery',
            customerId: jsonResponse['customer'],
            customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
            style: ThemeMode.light,
            testEnv: true,
            merchantCountryCode: 'US',
          ),
        );

        await Stripe.instance.presentPaymentSheet();

        orderSuccess = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Payment completed!')),
        );
      } catch (e) {
        if (e is StripeException) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${e.error.localizedMessage}'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }

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
                    User user = _auth.currentUser;
                    final _uid = user.uid;
                    double amountInCents = totalAmount * 1000;
                    int integerAmount = (amountInCents / 10).ceil();
                    // Stripe Payment Sheet
                    await initPaymentSheet(
                      context,
                      email: user.email,
                      amount: integerAmount,
                    );
                    // Firebase Orders
                    if (orderSuccess == true) {
                      cartProvider.getCartItems.forEach(
                        (key, orderValue) async {
                          final orderId = uuid.v4();
                          try {
                            await FirebaseFirestore.instance
                                .collection('orders')
                                .doc(orderId)
                                .set({
                              'orderId': orderId,
                              'userId': _uid,
                              'productId': orderValue.id,
                              'title': orderValue.name,
                              'quantity': orderValue.quantity,
                              'price': orderValue.price * orderValue.quantity,
                              'orderDate': Timestamp.now(),
                            });
                          } catch (err) {
                            print("Error occurred in $err");
                          }
                        },
                      );
                      // Clears orderSuccess after order is completed.
                      orderSuccess = false;
                    }
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
