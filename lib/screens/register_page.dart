import 'package:emilios_market/screens/login_page.dart';
import 'package:emilios_market/widgets/rounded_button.dart';
import 'package:emilios_market/widgets/rounded_input_field.dart';
import 'package:emilios_market/widgets/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Built an alert dialog to display errors
  Future<void> _alertDialogBuilder() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text("Text goes here"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Close Dialog"),
              )
            ],
          );
        });
  }

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
            SafeArea(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image:
                          AssetImage('assets/images/emilio-grocery-logo.png'),
                    ),
                    RoundedInputField(
                      hintText: "Name",
                      icon: Icons.person,
                      onChanged: (value) {},
                    ),
                    RoundedInputField(
                      hintText: "Phone Number",
                      icon: Icons.phone,
                      onChanged: (value) {},
                    ),
                    RoundedInputField(
                      hintText: "Email Address",
                      onChanged: (value) {},
                    ),
                    RoundedPasswordField(
                      onChanged: (value) {},
                    ),
                    RoundedButton(
                      text: "SIGN UP",
                      onPressed: () {
                        _alertDialogBuilder();
                      },
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Already have an Account? ",
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: Text(
                              "Back to Login",
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
            ),
          ],
        ),
      ),
    );
  }
}
