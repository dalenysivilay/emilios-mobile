import 'package:emilios_grocery/constants.dart';
import 'package:emilios_grocery/screens/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderConfirmation extends StatelessWidget {
  final String orderId;
  final String userId;

  const OrderConfirmation({
    Key key,
    @required this.orderId,
    @required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User user = _auth.currentUser;
    final _uid = user.uid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Order Confirmed!",
          textAlign: TextAlign.center,
          style: GoogleFonts.libreFranklin(textStyle: h1),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LandingPage()));
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 16.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: size.width,
            margin: EdgeInsets.only(
                top: 24.0, bottom: 24.0, left: 24.0, right: 24.0),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(35.07396943121907, -89.93218569969048),
                zoom: 15,
              ),
            ),
          ),
          Container(
            child: Text(
              "Your order number is #$orderId",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
