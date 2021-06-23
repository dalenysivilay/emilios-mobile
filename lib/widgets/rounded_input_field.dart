import 'package:emilios_market/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final IconData suffIcon;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final TextInputAction textInputAction;
  final bool isPasswordField;
  TextInputType keyboardType;
  List<TextInputFormatter> inputFormatters;
  RoundedInputField({
    this.hintText,
    this.icon,
    this.suffIcon,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.isPasswordField,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
          color: Color(0xFFF2F2F2), borderRadius: BorderRadius.circular(12.0)),
      child: TextField(
        keyboardType: keyboardType,
        cursorColor: kPrimaryColor,
        obscureText: _isPasswordField,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? "Hint Text...",
            prefixIcon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            suffixIcon: Icon(
              suffIcon,
              color: kPrimaryColor,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            )),
      ),
    );
  }
}
