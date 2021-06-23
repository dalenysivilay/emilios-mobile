import 'package:emilios_market/constants.dart';
import 'package:emilios_market/providers/cart_provider.dart';
import 'package:emilios_market/providers/product_provider.dart';
import 'package:emilios_market/screens/cart_page/cart_page.dart';
import 'package:emilios_market/screens/landing_page.dart';
import 'package:emilios_market/screens/menu_page.dart';
import 'package:emilios_market/screens/product_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ProductProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => CartProvider(),
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: LandingPage(),
      routes: {
        //   '/': (ctx) => LandingPage(),
        ProductPage.routeName: (ctx) => ProductPage(),
        CartPage.routeName: (ctx) => CartPage(),
        MenuPage.routeName: (ctx) => MenuPage(),
      },
    );
  }
}
