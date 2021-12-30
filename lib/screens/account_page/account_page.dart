import 'package:emilios_grocery/widgets/action_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/personal_page.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<void> _signOut() async {
      await FirebaseAuth.instance.signOut();
    }

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 120.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    accListTile("Personal", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonalPage(),
                          ));
                    }, context),
                    accListTile("Payment Methods", () {}, context),
                    accListTile("Help", () {}, context),
                    accListTile("Notifications", () {}, context),
                    accListTile("Sign Out", () {
                      _signOut();
                    }, context),
                  ],
                ),
              ),
            ),
            ActionBar(
              title: "Settings",
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
