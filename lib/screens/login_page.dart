import 'package:emilios_market/constants.dart';
import 'package:emilios_market/screens/register_page.dart';
import 'package:emilios_market/widgets/rounded_button.dart';
import 'package:emilios_market/widgets/rounded_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Create alert builder
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
                child: Text(
                  "Close Dialog",
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  // Create a new user account
  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail.toLowerCase().trim(),
          password: _loginPassword.trim());
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

  //Loading State
  void _submitForm() async {
    // Set the form to loading state
    setState(() {
      _loginFormLoading = true;
    });

    // Run the create account method
    String _loginFeedback = await _loginAccount();

    // If the string is not null, we got error while create account.
    if (_loginFeedback != null) {
      _alertDialogBuilder(_loginFeedback);

      // Set the form to regular state [not loading].
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  // Default Form Loading State
  bool _loginFormLoading = false;

  // Form Input Field Values
  String _loginEmail = "";
  String _loginPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/home-login-bg.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                const SizedBox(height: 14.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12.0,
                  ),
                  child: Image.asset(
                    'assets/images/emilio-grocery-logo.png',
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 50.0),
                    Text(
                      "Welcome!",
                      style: GoogleFonts.mitr(
                        textStyle: h1,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    RoundedInputField(
                      hintText: "Email...",
                      icon: Icons.email,
                      onChanged: (value) {
                        _loginEmail = value;
                      },
                      onSubmitted: (value) {},
                      textInputAction: TextInputAction.next,
                      isPasswordField: false,
                    ),
                    RoundedInputField(
                      hintText: "Password...",
                      icon: Icons.lock,
                      suffIcon: Icons.visibility,
                      onChanged: (value) {
                        _loginPassword = value;
                      },
                      isPasswordField: true,
                      onSubmitted: (value) {
                        _submitForm();
                      },
                      textInputAction: TextInputAction.done,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 24.0),
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Forgot your password?",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    RoundedButton(
                      text: "Login",
                      onPressed: () {
                        _submitForm();
                      },
                      isLoading: _loginFormLoading,
                      outlineBtn: false,
                    )
                  ],
                ),
                const SizedBox(height: 50.0),
                RoundedButton(
                  text: "Create New Account",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return RegisterPage();
                      }),
                    );
                  },
                  outlineBtn: true,
                ),
                const SizedBox(height: 14.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
