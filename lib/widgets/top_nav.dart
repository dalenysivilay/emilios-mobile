import 'package:emilios_grocery/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final bool hasBackArrow;

  TopAppBar({
    Key key,
    this.title,
    this.hasBackArrow,
  })  : preferredSize = Size.fromHeight(80.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;

    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.libreFranklin(textStyle: h1),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18.0,
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
