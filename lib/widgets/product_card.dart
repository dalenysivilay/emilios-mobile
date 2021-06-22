import 'package:emilios_market/models/product_model.dart';
import 'package:emilios_market/screens/product_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuProducts extends StatefulWidget {
  @override
  _MenuProductsState createState() => _MenuProductsState();
}

class _MenuProductsState extends State<MenuProducts> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productAtt = Provider.of<Product>(context);
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductPage.routeName),
      child: Container(
        width: size.width,
        height: 130.0,
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
        child: Row(
          children: [
            //Left Side of Product Card
            Column(
              children: [
                Container(
                  width: 120.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(productAtt.images),
                    ),
                  ),
                ),
              ],
            ),
            //Right Side of Product Card
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 14.0),
                child: Column(
                  children: [
                    //Food Name and Food Price Row
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              productAtt.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "\$ ${productAtt.price}",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Food Description Row
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              productAtt.desc,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
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
    );
  }
}
