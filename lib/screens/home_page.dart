import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emilios_market/constants.dart';
import 'package:emilios_market/models/product_model.dart';
import 'package:emilios_market/providers/product_provider.dart';
import 'package:emilios_market/screens/product_page.dart';
import 'package:emilios_market/widgets/action_bar.dart';
import 'package:emilios_market/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    productProvider.fetchProducts();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/home-login-bg.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 12.0,
                        ),
                        child: Image.asset(
                          'assets/images/emilio-grocery-logo.png',
                        ),
                      ),
                      SizedBox(
                        height: 100.0,
                      ),
                      RoundedButton(
                        text: "See Menu",
                      )
                    ],
                  ),
                ),
              ),
            ),
            ActionBar(
              title: "Welcome",
            ),
          ],
        ),
      ),
    );
  }
}
