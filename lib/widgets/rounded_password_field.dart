import 'package:emilios_market/constants.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        focusNode: focusNode,
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          hintText: "Password",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
