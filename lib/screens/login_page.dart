import 'package:emilios_market/screens/register_page.dart';
import 'package:emilios_market/widgets/rounded_button.dart';
import 'package:emilios_market/widgets/rounded_input_field.dart';
import 'package:emilios_market/widgets/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              child: Image(
                image: AssetImage('assets/images/home-login-bg.png'),
                fit: BoxFit.cover,
                height: size.height,
                width: double.infinity,
              ),
            ),
            body(),
          ],
        ),
      ),
    );
  }
}

class body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/emilio-grocery-logo.png'),
            ),
            RoundedInputField(
              hintText: "Email Address",
              onChanged: (value) {},
              onSubmitted: () {},
              textInputAction: TextInputAction.next,
            ),
            RoundedButton(
              isLoading: false,
              text: "LOGIN",
              onPressed: () {},
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                "Don't have an Account? ",
                style: TextStyle(
                  color: kPrimaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
