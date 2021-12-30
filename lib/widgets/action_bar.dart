import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emilios_grocery/constants.dart';

import 'package:emilios_grocery/providers/cart_provider.dart';
import 'package:emilios_grocery/screens/cart_page/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ActionBar extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool hasBackArrow;
  final bool hasTitle;

  ActionBar({
    this.title,
    this.hasBackArrow,
    this.hasTitle,
    this.onTap,
  });

  //FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    final cartProvide = Provider.of<CartProvider>(context);

    int itemAmount = cartProvide.getCartItems.length;

    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;

    return Container(
      padding: EdgeInsets.only(
        top: 56.0,
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 0.5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 16.0,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              title ?? "Action Bar",
              style: GoogleFonts.libreFranklin(textStyle: h1),
            ),
          InkWell(
            onTap: () {
              onTap ?? Navigator.pushNamed(context, CartPage.routeName);
            },
            child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  "$itemAmount",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
                /* StreamBuilder(
                // stream: _usersRef.doc(_firebaseServices.getUserId()).collection("Cart").snapshots(),
                builder: (context, snapshot) {
                  int _totalItems = 0;

                  if (snapshot.connectionState == ConnectionState.active) {
                    List _documents = snapshot.data.docs;
                    _totalItems = _documents.length;
                  }

                  return Text(
                    "$_totalItems" ?? "0",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  );
                },
              ), */
                ),
          )
        ],
      ),
    );
  }
}
