import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signupController extends GetxController {
  static signupController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final contactno = TextEditingController();
  final fullname = TextEditingController();

  void registerUser(String email, String password){
    AuthenticationRepository.instance.createUserWithEmailandPassword(email, password);
  }
  void clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Reset the controller values
    fullname.value = '' as TextEditingValue;
    email.value = '' as TextEditingValue;
    contactno.value = '' as TextEditingValue;
    password.value = '' as TextEditingValue;
  }

}