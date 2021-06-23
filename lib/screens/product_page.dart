import 'package:emilios_market/providers/cart_provider.dart';
import 'package:emilios_market/providers/product_provider.dart';
import 'package:emilios_market/widgets/action_bar.dart';
import 'package:emilios_market/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/ProductPage';

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context);
    final productId = ModalRoute.of(context).settings.arguments as String;
    final prodAttr = productsData.findById(productId);
    final productsList = productsData.products;
    print("productId: $productId");
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(prodAttr.id),
                  Text(prodAttr.name),
                  Text(prodAttr.desc),
                  Text("\$ ${prodAttr.price}"),
                  RoundedButton(
                    text: "Add to Cart",
                    onPressed: () {
                      cartProvider.addProductToCart(productId, prodAttr.name,
                          prodAttr.price, prodAttr.images);
                    },
                  ),
                ],
              ),
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
