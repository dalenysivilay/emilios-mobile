import 'package:emilios_market/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

Widget checkoutSection(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Divider(),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
        child: Column(
          children: [
            //Subtotal Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Subtotal",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  "4.99",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            //Taxes Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tax",
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  "4.99",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            //Total Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  "4.99",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
          ],
        ),
      ),
      //Continue to Payment Button
      Container(
        margin: EdgeInsets.only(bottom: 14.0),
        child: RoundedButton(
          text: "Continue to Payment",
          onPressed: () {},
        ),
      ),
    ],
  );
}
