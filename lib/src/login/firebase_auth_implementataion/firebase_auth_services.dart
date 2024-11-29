
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_page/global/common/toast.dart';
import 'package:get/get.dart';

class FirebaseAuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var verificationId = ''.obs;

  Future<void> phoneAutnentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo  ,
        verificationCompleted: (credential)async{
          await _auth.signInWithCredential(credential);
        },
        codeSent: (verificationId,resendToken){
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId){
          this.verificationId.value = verificationId;
        },
        verificationFailed: (e){
          if(e.code == "invalid-phone-number"){
            Get.snackbar("Error", "The provided phone number is not valid");
          }else{
            Get.snackbar("Error", "Something went wrong, Try Again");
          }
        },
    );
  }

  Future<bool> verifyOTP(String otp)async{
    var credetials = await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: this.verificationId.value, smsCode: otp));
    return credetials.user != null ? true : false;
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }on FirebaseAuthException catch(e){
      if(e.code == "email-already-in-use"){
        showToast(message: "Email already in use.");
      }else{
        showToast(message: "An error occureed: ${e.code}");
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }on FirebaseAuthException catch(e){
      if(e.code == "user-not-found" || e.code == "wrong-password"){
        showToast(message: "Invalid Email or Password. ");
      }else{
        showToast(message: "An error occurred: ${e.code}");
      }
    }
    return null;
  }
}