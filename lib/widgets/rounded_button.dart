import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isLoading;

  RoundedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isLoading = isLoading ?? false;
    Size size = MediaQuery.of(context).size;
    double width = size.width * 0.75;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        onPressed: () => onPressed(),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
        style: TextButton.styleFrom(
          minimumSize: Size(width, 50),
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
