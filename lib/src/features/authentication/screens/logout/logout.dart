import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_page/src/features/authentication/controllers/SidebarController/sidebarController.dart';
import 'package:flutter_login_page/src/features/authentication/screens/login_screen/LoginPage.dart';

void logoutUser(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Get.find<SidebarController>().clearUserData(); // Clear user data from storage
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );
}
