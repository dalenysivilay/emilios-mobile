import 'package:emilios_grocery/constants.dart';
import 'package:emilios_grocery/screens/menu_page.dart';
import 'package:emilios_grocery/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CartEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 140.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Your Cart is Empty",
              textAlign: TextAlign.center,
              style: GoogleFonts.libreFranklin(textStyle: h1),
            ),
            Text(
              "Add items to your cart.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            SvgPicture.asset(
              "assets/icons/waitress-empty-cart.svg",
              height: size.height * 0.3,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 24.0),
              child: RoundedButton(
                text: "See Menu",
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
