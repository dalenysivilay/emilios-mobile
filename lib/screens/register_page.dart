import 'package:emilios_market/screens/login_page.dart';
import 'package:emilios_market/widgets/rounded_button.dart';
import 'package:emilios_market/widgets/rounded_input_field.dart';
import 'package:emilios_market/widgets/rounded_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Built an alert dialog to display errors
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
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

  //Default form loading State
  bool _registerFormLoading = false;

  //Create New User account
  Future<String?> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    //Set form to loading state
    setState(() {
      _registerFormLoading = true;
    });
    //Run create account method
    String? _createAccountFeedback = await _createAccount();
    //If string is not null there is an error while creating account
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);
      // Set the form to regular state [not loading].
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      //String was null, user is logged in
      Navigator.pop(context);
    }
  }

  //Form Input Field Values
  String _registerEmail = "";
  String _registerPassword = "";
  String _registerName = "";
  String _registerPhone = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
            ListView(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                        image:
                            AssetImage('assets/images/emilio-grocery-logo.png'),
                      ),
                      RoundedInputField(
                        hintText: "Email Address",
                        onChanged: (value) {
                          _registerEmail = value;
                        },
                        onSubmitted: (value) {},
                        textInputAction: TextInputAction.next,
                      ),
                      RoundedPasswordField(
                        onChanged: (value) {
                          _registerPassword = value;
                        },
                        onSubmitted: (value) {
                          _submitForm();
                        },
                      ),
                      RoundedButton(
                        isLoading: _registerFormLoading,
                        text: "SIGN UP",
                        onPressed: () {
                          _submitForm();
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
