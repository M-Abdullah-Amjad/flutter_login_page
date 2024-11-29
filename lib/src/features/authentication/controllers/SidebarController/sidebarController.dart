import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login_page/global/common/toast.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SidebarController extends GetxController {
  var name = "".obs;
  var email = "".obs;
  var contact = "".obs;
  var password = "".obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserDataFromLocalStorage();
  }

  void updateUserData(String username, String userEmail, String userContact, String userPassword) async {
    name.value = username;
    email.value = userEmail;
    contact.value = userContact;
    password.value = userPassword;

    // Save data to local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('email', userEmail);
    await prefs.setString('contact', userContact);
    await prefs.setString('password', userPassword);
  }

  void fetchUserData(String eemail) async {
    try {
      email.value = eemail;
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final DocumentSnapshot snapshot = await _firestore.collection('users').doc(email.value).get();

      if (snapshot.exists) {
        final userData = snapshot.data() as Map<String, dynamic>;
        updateUserData(
          userData['username'],
          userData['email'],
          userData['phone_number'],
          userData['password'],
        );
        showToast(message: "User data fetched successfully!");
      } else {
        showToast(message: "No user data found for the provided email.");
        print('No user data found');
      }
    } catch (e) {
      showToast(message: "Error fetching user data: $e");
      print('Error fetching user data: $e');
    }
  }

  void _loadUserDataFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? userEmail = prefs.getString('email');
    String? userContact = prefs.getString('contact');
    String? userPassword = prefs.getString('password');

    if (userEmail != null && username != null && userContact != null && userPassword != null) {
      updateUserData(username, userEmail, userContact, userPassword);
    }
  }

  void clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Reset the controller values
    name.value = '';
    email.value = '';
    contact.value = '';
    password.value = '';

    showToast(message: "User data out");
  }
}
