import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emilios_market/providers/cart_provider.dart';
import 'package:emilios_market/providers/product_provider.dart';
import 'package:emilios_market/widgets/action_bar.dart';
import 'package:emilios_market/services/firebase_services.dart';
import 'package:emilios_market/widgets/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/ProductPage';

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String _chosenValue;
  double subtotal = 0.0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsData = Provider.of<ProductProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context);
    final productId = ModalRoute.of(context).settings.arguments as String;
    final prodAttr = productsData.findById(productId);
    final productsList = productsData.products;
    print("productId: $productId");
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                //Product Image Section
                Container(
                  height: 200,
                  width: size.width,
                  margin: EdgeInsets.only(top: 110.0, left: 24.0, right: 24.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: NetworkImage(prodAttr.images),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                //Product Info
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                  child: Text(
                    prodAttr.desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),
                Text("\$ ${prodAttr.price}"),
                Text("Select Meat"),
                //DROPDOWN MENU
                Container(
                  padding: const EdgeInsets.all(0.0),
                  child: DropdownButton<String>(
                    value: _chosenValue,
                    //elevation: 5,
                    style: TextStyle(color: Colors.black),

                    items: <String>[
                      'Steak',
                      'Chicken',
                      'Barbacoa',
                      'Carnitas',
                      'Chorizo',
                      'Chicharron',
                      'Birria',
                      'Beef Tongue',
                      'Fish (+\$1.50)',
                      'Shrimp (+\$1.50)'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
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
                    onChanged: (String value) {
                      setState(() {
                        _chosenValue = value;
                        if (_chosenValue == 'Fish (+\$1.50)') {
                          subtotal = prodAttr.price + 1.50;
                        }
                        if (_chosenValue == 'Shrimp (+\$1.50)') {
                          subtotal = prodAttr.price + 1.50;
                        } else {
                          subtotal = 0.0;
                        }
                        return subtotal;
                      });
                    },
                  ),
                ),
                Text("Subtotal"),
                RoundedButton(
                  text: "Add to Cart",
                  onPressed: cartProvider.getCartItems.containsKey(productId)
                      ? () {}
                      : () {
                          cartProvider.addProductToCart(
                              productId,
                              prodAttr.name,
                              _chosenValue,
                              subtotal,
                              prodAttr.images);
                        },
                ),
              ],
            ),
            ActionBar(
              title: prodAttr.name,
              hasBackArrow: true,
            ),
          ],
        ),
      ),
    );
  }
}
