import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emilios_market/constants.dart';
import 'package:emilios_market/models/product_model.dart';
import 'package:emilios_market/providers/product_provider.dart';
import 'package:emilios_market/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    List<Product> productsList = productProvider.products;

    return Scaffold(
      appBar: new AppBar(
        title: Text("Menu"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: ListView.builder(
        itemCount: productsList.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: productsList[index],
            child: MenuProducts(),
          );
        },
      ),
    );
  }
}
