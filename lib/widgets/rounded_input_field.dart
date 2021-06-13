import 'package:emilios_market/constants.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function onSubmitted;
  final TextInputAction textInputAction;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.onSubmitted,
    required this.textInputAction,
    this.icon = Icons.mail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        onSubmitted: onSubmitted(),
        textInputAction: textInputAction,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
