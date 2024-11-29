import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page/firebase_options.dart';
import 'package:flutter_login_page/src/features/authentication/controllers/SidebarController/sidebarController.dart';
import 'package:flutter_login_page/src/features/authentication/screens/Auth_Check/AuthCheck.dart';
import 'package:flutter_login_page/src/features/authentication/screens/login_screen/LoginPage.dart';
import 'package:flutter_login_page/src/utils/theme/theme.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LoginPage loginPage = LoginPage();

  // Initialize Firebase
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyB7mq6Eefjgxkdg5dEweYxKPyCzUoHS0Jo",
        appId: "1:846524652631:web:ee0ac1c1eb3d6af2861712",
        messagingSenderId: "846524652631",
        projectId: "login-app-d5d06",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // Initialize SidebarController
  Get.put(SidebarController());

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Get.find<SidebarController>().fetchUserData(user.email!
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Login Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      darkTheme: TAppTheme.darkttheme,
      themeMode: ThemeMode.dark,
      home: AuthCheck(),
    );
  }
}
