
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_page/src/features/authentication/screens/Dashboard/Dashboard.dart';
import 'package:flutter_login_page/src/features/authentication/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter_login_page/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady(){
    Future.delayed(Duration(seconds: 6));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user){
    user == null ? Get.offAll(()=>  WelcomeScreen()): Get.offAll(()=>Dashboard());
  }



  Future <void> createUserWithEmailandPassword (String email, String password) async {

    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){

    } catch(_) {}

  }

  Future <void> loginUserWithEmailandPassword (String email, String password) async {

    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(()=>const Dashboard()) : Get.to(()=>WelcomeScreen());
    } on FirebaseAuthException catch (e){
      final ex = SignupEmailPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch(_) {
      final ex =  SignupEmailPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }

  }

  Future<void> logout() async => await _auth.signOut();

}
//
//
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthenticationRepository {
//   static final AuthenticationRepository instance = AuthenticationRepository._();
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   AuthenticationRepository._();
//
//   Future<bool> createUserWithEmailandPassword(String email, String password) async {
//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
//       return true; // Registration successful
//     } catch (e) {
//       print(e);
//       return false; // Registration failed
//     }
//   }
//
//   Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//       return userCredential.user; // Login successful
//     } catch (e) {
//       print(e);
//       return null; // Login failed
//     }
//   }
//
//   Future<void> logout() async {
//     await _firebaseAuth.signOut();
//   }
//
//   Future<User?> getCurrentUser() async {
//     return _firebaseAuth.currentUser;
//   }
// }

