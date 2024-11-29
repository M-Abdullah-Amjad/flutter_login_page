import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page/src/features/authentication/screens/Dashboard/Dashboard.dart';
import 'package:flutter_login_page/src/features/authentication/screens/welcome_screen/welcome_screen.dart';

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return Dashboard();
        } else {
          return WelcomeScreen();
        }
      },
    );
  }
}
