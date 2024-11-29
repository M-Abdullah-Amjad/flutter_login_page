import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page/global/common/toast.dart';
import 'package:flutter_login_page/src/features/authentication/screens/login_screen/LoginPage.dart';
import 'package:flutter_login_page/src/login/firebase_auth_implementataion/firebase_auth_services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../controllers/SidebarController/sidebarController.dart';
import '../../controllers/signupController/signupController.dart';
import '../Dashboard/Dashboard.dart';
import '../welcome_screen/welcome_screen.dart';

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool isSigningup = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final SidebarController _sidebarController = Get.find<SidebarController>();
  @override
  void initState() {
    _sidebarController.fetchUserData(_emailcontroller.text);
  }

  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _numbercontroller = TextEditingController(text: "+92 ");

  @override
  void dispose() {
    _usernamecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _numbercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final controller = Get.put(signupController());

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
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              const Image(image: AssetImage("assets/images/sign.png")),
              const SizedBox(height: 10),
              const Text(
                "Create Your Account",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernamecontroller,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Full Name",
                        labelText: "Full Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "Email",
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _numbercontroller,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.call),
                        hintText: "Phone No",
                        labelText: "Phone No",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _passwordcontroller,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.fingerprint),
                        suffixIcon: Icon(Icons.remove_red_eye),
                        hintText: "Password",
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => _signUp(
                        _emailcontroller.text.toString(),
                        _passwordcontroller.text.toString(),
                        _usernamecontroller.text.toString(),
                        _numbercontroller.text.toString(),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: isSigningup
                              ? CircularProgressIndicator(color: Colors.red)
                              : Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("OR"),
                        const Text(" "),
                        OutlinedButton.icon(
                          icon: const Image(
                            image: AssetImage("assets/images/google.png"),
                            width: 20,
                          ),
                          label: const Text(
                            "Sign-in with Google",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: _signInWithGoogle,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account,"),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                );
                              },
                              child: Text(
                                "Log in",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
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

  Future<void> _signUp(String email, String password, String username, String number) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty || number.isEmpty) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Fill all Required Fields"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        isSigningup = true;
      });

      try {
        User? user = await _auth.signUpWithEmailAndPassword(email, password);
        setState(() {
          isSigningup = false;
        });

        if (user != null) {
          // Ensure that the user document is created with proper data
          await FirebaseFirestore.instance.collection('users').doc(user.email).set({
            'username': username,
            'email': email,
            'phone_number': number,
            'password': password,
          });

          showToast(message: "User is created successfully now login");

          // Update SidebarController
          Get.find<SidebarController>().updateUserData(username, email, number, password);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        } else {
          showToast(message: "Some error happened....");
        }
      } catch (e) {
        setState(() {
          isSigningup = false;
        });
        showToast(message: e.toString());
      }
    }
  }



  Future<void> _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        await _firebaseAuth.signInWithCredential(credential);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
      }
    } catch (e) {
      showToast(message: "An error occurred: $e");
    }
  }
}
