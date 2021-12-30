import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emilios_grocery/screens/login_page.dart';
import 'package:emilios_grocery/widgets/rounded_button.dart';
import 'package:emilios_grocery/widgets/rounded_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
  Future<String> _createAccount() async {
    //Current date for user registration
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.month}-${dateParse.day}-${dateParse.year}";
    try {
      await _auth.createUserWithEmailAndPassword(
          email: _registerEmail.toLowerCase().trim(),
          password: _registerPassword.trim());
      final User user = _auth.currentUser;
      final _uid = user.uid;
      FirebaseFirestore.instance.collection('users').doc(_uid).set({
        'id': _uid,
        'name': _fullName,
        'email': _registerEmail,
        'phoneNumber': _phoneNumber,
        'joinedAt': formattedDate,
        'createdAt': Timestamp.now(),
      });
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
  String _fullName = "";
  int _phoneNumber;

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
                      "Create Account",
                      style: GoogleFonts.mitr(
                        textStyle: h1,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    RoundedInputField(
                      hintText: "Name...",
                      icon: Icons.person,
                      onChanged: (value) {
                        _fullName = value;
                      },
                      onSubmitted: (value) {},
                      textInputAction: TextInputAction.next,
                      isPasswordField: false,
                    ),
                    RoundedInputField(
                      hintText: "Phone Number...",
                      icon: Icons.phone,
                      onChanged: (value) {
                        _phoneNumber = int.parse(value);
                      },
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.phone,
                      onSubmitted: (value) {},
                      textInputAction: TextInputAction.next,
                      isPasswordField: false,
                    ),
                    RoundedInputField(
                      hintText: "Email...",
                      icon: Icons.email,
                      onChanged: (value) {
                        _registerEmail = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      onSubmitted: (value) {},
                      textInputAction: TextInputAction.next,
                      isPasswordField: false,
                    ),
                    RoundedInputField(
                      hintText: "Password...",
                      icon: Icons.lock,
                      suffIcon: Icons.visibility,
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
                      text: "Register",
                      onPressed: () {
                        _submitForm();
                      },
                      isLoading: _registerFormLoading,
                      outlineBtn: false,
                    )
                  ],
                ),
                const SizedBox(height: 50.0),
                RoundedButton(
                  text: "Back to Login",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return LoginPage();
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
