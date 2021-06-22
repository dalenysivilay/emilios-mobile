import 'package:flutter/material.dart';
import 'package:emilios_market/models/product_model.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  static const routeName = '/ProductPage';

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: new AppBar(
          title: Text("Product Page"),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: size.width,
              height: size.height * 0.25,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/sample-food.jpg'),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Description",
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Description",
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ));
  }
}
