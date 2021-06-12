import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  RoundedButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width * 0.75;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          TextButton(
            onPressed: () => onPressed(),
            child: Text(
              text,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            style: TextButton.styleFrom(
              minimumSize: Size(width, 20),
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
