import 'package:emilios_grocery/providers/cart_provider.dart';
import 'package:emilios_grocery/providers/product_provider.dart';
import 'package:emilios_grocery/screens/cart_page/cart_page.dart';
import 'package:emilios_grocery/screens/landing_page.dart';
import 'package:emilios_grocery/screens/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // set the publishable key for Stripe - this is mandatory
  Stripe.publishableKey =
      "pk_test_51J5LrvGYanMuZ0VtBxKsummLvVTsn5zeMTtCBQtZLFZCSOKXGRpMbtZ9uweziazX1Z6NrivtvSDiW6oHOmGa5tZz00pArSUKYN";
  Stripe.merchantIdentifier = 'any string works';
  await Stripe.instance.applySettings();
  runApp(
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
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        primaryColor: Colors.white,
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: LandingPage(),
      routes: {
        //   '/': (ctx) => LandingPage(),
        ProductPage.routeName: (ctx) => ProductPage(),
        CartPage.routeName: (ctx) => CartPage(),
        ProductPage.routeName: (ctx) => ProductPage(),
      },
    );
  }
}
