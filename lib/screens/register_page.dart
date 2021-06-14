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
  // Build an alert dialog to display some errors.
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
                child: Text("Close Dialog"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  // Create a new user account
  Future<String> _createAccount() async {
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
    // Set the form to loading state
    setState(() {
      _registerFormLoading = true;
    });

    // Run the create account method
    String _createAccountFeedback = await _createAccount();

    // If the string is not null, we got error while create account.
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);

      // Set the form to regular state [not loading].
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      // The String was null, user is logged in.
      Navigator.pop(context);
    }
  }

  // Default Form Loading State
  bool _registerFormLoading = false;

  // Form Input Field Values
  String _registerEmail = "";
  String _registerPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 24.0,
                ),
                child: Text(
                  "Create A New Account",
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: [
                  RoundedInputField(
                    hintText: "Email...",
                    onChanged: (value) {
                      _registerEmail = value;
                    },
                    onSubmitted: (value) {},
                    textInputAction: TextInputAction.next,
                    isPasswordField: false,
                  ),
                  RoundedInputField(
                    hintText: "Password...",
                    onChanged: (value) {
                      _registerPassword = value;
                    },
                    isPasswordField: true,
                    onSubmitted: (value) {
                      _submitForm();
                    },
                    textInputAction: TextInputAction.done,
                  ),
                  RoundedButton(
                    text: "Create New Account",
                    onPressed: () {
                      _submitForm();
                    },
                    isLoading: _registerFormLoading,
                    outlineBtn: false,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: RoundedButton(
                  text: "Back To Login",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  isLoading: _registerFormLoading,
                  outlineBtn: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
