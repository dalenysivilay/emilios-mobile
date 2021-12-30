import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emilios_grocery/widgets/action_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _uid;

  String _name;

  String _email;

  int _phoneNumber;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    User user = _auth.currentUser;
    _uid = user.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();

    setState(() {
      _name = userDoc.get('name');
      _email = user.email;
      _phoneNumber = userDoc.get('phoneNumber');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 140.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    accListTile("Name", "$_name", () {}, context),
                    accListTile("Email", "$_email", () {}, context),
                    accListTile(
                        "Phone Number", "$_phoneNumber", () {}, context),
                  ],
                ),
              ),
            ),
            ActionBar(
              title: "Personal",
              hasBackArrow: true,
            )
          ],
        ),
      ),
    );
  }

  Widget accListTile(
      String title, String subTitle, Function onPressed, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap: onPressed,
          title: Text(title),
          subtitle: Text(subTitle),
        ),
      ),
    );
  }
}
