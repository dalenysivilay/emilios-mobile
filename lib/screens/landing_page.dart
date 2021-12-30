import 'package:emilios_grocery/screens/login_page.dart';
import 'package:emilios_grocery/widgets/bottom_nav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error:  ${snapshot.error}"),
            ),
          );
        }
        // Connection Initialized - Firebase App is running
        if (snapshot.connectionState == ConnectionState.done) {
          // StreamBuilder checks the login state
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error:  ${streamSnapshot.error}"),
                  ),
                );
              }
              // Connection state is active - Check user login
              if (streamSnapshot.connectionState == ConnectionState.active) {
                //Get user
                User _user = streamSnapshot.data;
                //If user is null, user is not logged in
                if (_user == null) {
                  return LoginPage();
                  //User is logged in
                } else {
                  return BottomNav();
                }
              }
              // Checking the auth state - Loading
              return Scaffold(
                body: Center(
                  child: Text("Checking Authentication..."),
                ),
              );
            },
          );
        }
        // Connecting to Firebase - Loading
        return Scaffold(
          body: Center(
            child: Text("Initializing App..."),
          ),
        );
      },
    );
  }
}
