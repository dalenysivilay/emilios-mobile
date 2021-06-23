import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emilios_market/constants.dart';
import 'package:emilios_market/models/product_model.dart';
import 'package:emilios_market/providers/product_provider.dart';
import 'package:emilios_market/widgets/action_bar.dart';
import 'package:emilios_market/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  static const routeName = '/MenuPage';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);
    List<Product> productsList = productProvider.products;

    return SafeArea(
      child: Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.only(top: 96.0),
            itemCount: productsList.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: productsList[index],
                child: MenuProducts(),
              );
            },
          ),
          ActionBar(
            title: "Menu",
            hasBackArrow: false,
          ),
        ],
      ),
    );
  }
}
