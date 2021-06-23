import 'package:emilios_market/widgets/action_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 80.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    accListTile("Personal Information", () {}, context),
                    accListTile("Payment Method", () {}, context),
                    accListTile("Help", () {}, context),
                    accListTile("Notifications", () {}, context),
                    accListTile("Sign Out", () {}, context),
                  ],
                ),
              ),
            ),
            ActionBar(
              title: "Account Settings",
              hasBackArrow: false,
            )
          ],
        ),
      ),
    );
  }

  Widget accListTile(String title, Function onPressed, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap: onPressed,
          title: Text(title),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ),
    );
  }
}
