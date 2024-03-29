import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emilios_grocery/models/product_model.dart';
import 'package:emilios_grocery/providers/cart_provider.dart';
import 'package:emilios_grocery/providers/product_provider.dart';
import 'package:emilios_grocery/widgets/action_bar.dart';
import 'package:emilios_grocery/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/ProductPage';
  final List<Product> products;
  final bool isMultiSelection;

  const ProductPage({
    Key key,
    this.products = const [],
    this.isMultiSelection = true,
  }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String _meats;
  double subtotal = 0.0;
  double upCharge = 0.0;
  List<Product> selectedIngr = [];

  //User -> UserID (Doc) -> Cart ->
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');

  User _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();

    selectedIngr = widget.products;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsData = Provider.of<ProductProvider>(context, listen: false);
    final allIngredients = productsData.products;
    final _ingredients = allIngredients.toList();
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
                  /* Ingredients List
                  const SizedBox(height: 15.0),
                  Container(
                    child: ListView(
                      children: _ingredients.map((product) {
                        final isSelected = selectedIngr.contains(product);
                        return IngredientItem(
                          product: product,
                          isSelected: isSelected,
                          onSelectedIngr: selectIngr,
                        );
                      }).toList(),
                    ),
                  ),
                   */
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

  void selectIngr(Product product) {
    if (widget.isMultiSelection) {
      final isSelected = selectedIngr.contains(product);
      setState(() => isSelected
          ? selectedIngr.remove(product)
          : selectedIngr.add(product));
    } else {
      Navigator.pop(context, product);
    }
  }
}
