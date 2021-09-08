import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emilios_market/providers/cart_provider.dart';
import 'package:emilios_market/providers/product_provider.dart';
import 'package:emilios_market/widgets/action_bar.dart';
import 'package:emilios_market/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/ProductPage';

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String _meats;
  double subtotal = 0.0;
  double upCharge = 0.0;

  //User -> UserID (Doc) -> Cart ->
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');

  User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsData = Provider.of<ProductProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context);
    final productId = ModalRoute.of(context).settings.arguments as String;
    final prodAttr = productsData.findById(productId);
    print("productId: $productId");
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Column(
                children: [
                  //Product Image Section
                  Container(
                    height: 200,
                    width: size.width,
                    margin:
                        EdgeInsets.only(top: 120.0, left: 24.0, right: 24.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: NetworkImage(prodAttr.images),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  //Product Info
                  const SizedBox(height: 12.0),
                  Text(
                    "\$ ${prodAttr.price + upCharge}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                    child: Text(
                      prodAttr.desc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  //DROPDOWN MENU
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    child: DropdownButton<String>(
                      value: _meats,
                      //elevation: 5,
                      style: TextStyle(color: Colors.black),

                      items:
                          prodAttr.meats.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(
                        "Choose your meat",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _meats = value;
                          print(_meats);
                          if (_meats == 'Fish (+\$1.50)') {
                            subtotal = prodAttr.price + 1.50;
                            upCharge = 1.50;
                          }
                          if (_meats == 'Shrimp (+\$1.50)') {
                            subtotal = prodAttr.price + 1.50;
                            upCharge = 1.50;
                          } else {
                            subtotal = prodAttr.price;
                            upCharge = 0.0;
                          }
                          return subtotal;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 90.0),
                ],
              ),
            ],
          ),
          ActionBar(
            title: prodAttr.name,
            hasBackArrow: true,
          ),
        ],
      ),
      floatingActionButton: RoundedButton(
        text: "Add to Cart",
        onPressed: cartProvider.getCartItems.containsKey(productId)
            ? () {}
            : () {
                cartProvider.addProductToCart(productId, prodAttr.name, _meats,
                    subtotal, prodAttr.images);
              },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
