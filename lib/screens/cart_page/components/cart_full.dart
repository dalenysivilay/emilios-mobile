import 'package:emilios_grocery/models/cart_model.dart';
import 'package:emilios_grocery/providers/cart_provider.dart';
import 'package:emilios_grocery/screens/product_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartFull extends StatefulWidget {
  final String id;
  final productId;
  final double price;
  final int quantity;
  final String name;
  final String images;

  const CartFull(
      {Key key,
      @required this.id,
      @required this.productId,
      @required this.price,
      @required this.quantity,
      @required this.name,
      @required this.images})
      : super(key: key);
  @override
  _CartFullState createState() => _CartFullState();
}

class _CartFullState extends State<CartFull> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartProvider = Provider.of<CartModel>(context);
    final cartAttr = Provider.of<CartProvider>(context);
    double subTotal = cartProvider.price * cartProvider.quantity;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductPage.routeName,
          arguments: widget.productId),
      child: Column(
        children: [
          //Product Card Size
          Container(
            width: size.width,
            height: 100.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
            child: Container(
              child: Row(
                children: [
                  //Left Side of Product Card
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(cartProvider.images),
                      ),
                    ),
                  ),
                  //Right Side of Product Card
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 16.0, top: 14.0, right: 14.0, bottom: 14.0),
                      child: Column(
                        children: [
                          //Food Name and Food Price Row
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    cartProvider.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  "\$ ${subTotal.toStringAsFixed(2)}",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //Food Meat Selection Row
                          Container(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    cartProvider.meats,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //Space Between
                          Spacer(),
                          //Quantity Selector
                          Container(
                            //Quantity and Trash Row
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Quantity Widget
                                Column(
                                  children: [
                                    Row(children: [
                                      //Minus Button
                                      InkWell(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        splashColor:
                                            Theme.of(context).splashColor,
                                        onTap: cartProvider.quantity < 2
                                            ? null
                                            : () {
                                                cartAttr.reduceItemByOne(
                                                    widget.productId,
                                                    cartProvider.name,
                                                    cartProvider.meats,
                                                    cartProvider.price,
                                                    cartProvider.images);
                                              },
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 15.0,
                                          ),
                                        ),
                                      ),
                                      //Quantity Number
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          cartProvider.quantity.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      //Add Button
                                      InkWell(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        splashColor:
                                            Theme.of(context).splashColor,
                                        onTap: () {
                                          cartAttr.addProductToCart(
                                              widget.productId,
                                              cartProvider.name,
                                              cartProvider.meats,
                                              cartProvider.price,
                                              cartProvider.images);
                                        },
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.lightGreen,
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 15.0,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                                //Trash or Remove Widget
                                Column(
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(4.0),
                                      splashColor:
                                          Theme.of(context).splashColor,
                                      onTap: () {
                                        cartAttr.removeItem(widget.productId);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
