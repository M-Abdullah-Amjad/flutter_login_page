import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page/global/common/toast.dart';
import 'package:flutter_login_page/src/features/authentication/controllers/SidebarController/sidebarController.dart';
import 'package:flutter_login_page/src/features/authentication/screens/Dashboard/Dashboard.dart';
import 'package:flutter_login_page/src/features/authentication/screens/Verification/emailveri.dart';
import 'package:flutter_login_page/src/features/authentication/screens/signup/signup.dart';
import 'package:flutter_login_page/src/features/authentication/screens/welcome_screen/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../login/firebase_auth_implementataion/firebase_auth_services.dart';
import '../Verification/phoneveri.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
// This boolean will keep track of whether the text is obscured or not
  bool _obscureText = true;

  // Function to toggle the visibility of the text
  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final SidebarController _sidebarController = Get.find<SidebarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Image(image: AssetImage("assets/images/stand.png")),
              const Text(
                "Welcome back, to Login Page",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_outlined),
                        hintText: "Email",
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      obscureText: _obscureText,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Password",
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                        // The eye icon button is added here
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Change the icon based on the _obscureText state
                            _obscureText ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: _toggleVisibility,
                        ),
                      ),),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Make Selection!",
                                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "Select an option below to reset your password.",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => EmailVerification());
                                    },
                                    child: _buildResetOption(
                                      icon: Icons.mail_outline,
                                      title: "Email",
                                      description: "Reset via Email Verification",
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => PhoneVerification());
                                    },
                                    child: _buildResetOption(
                                      icon: Icons.mobile_friendly_outlined,
                                      title: "Phone No.",
                                      description: "Reset via Phone No. Verification",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue,
                          alignment: Alignment.centerRight,
                        ),
                        child: const Text("Forget Password"),
                      ),
                    ),
                    GestureDetector(
                      onTap: _signIn,
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: _isSigning
                              ? CircularProgressIndicator(color: Colors.red)
                              : Text(
                            "Login",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("OR"),
                        const Text(" "),
                        OutlinedButton.icon(
                          icon: const Image(image: AssetImage("assets/images/google.png"), width: 20),
                          label: const Text(
                            "Sign-in with Google",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: _signInWithGoogle,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account"),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => signup()));
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResetOption({required IconData icon, required String title, required String description}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      child: Row(
        children: [
          Icon(icon, size: 50, color: Colors.black),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);

        _sidebarController.fetchUserData(_emailController.text); // Fetch user data after signing in

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      }
    } catch (e) {
      showToast(message: "An error occurred: $e");
    }
  }

  Future<void> _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      _sidebarController.fetchUserData(_emailController.text); // Fetch user data after signing in

      showToast(message: "User is successfully signed in");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else {
      showToast(message: "Failed to sign in");
    }
  }
}
