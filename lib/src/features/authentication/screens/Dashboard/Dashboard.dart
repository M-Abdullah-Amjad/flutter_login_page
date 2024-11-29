import 'package:flutter/material.dart';
import 'package:flutter_login_page/src/features/authentication/screens/SideBar/sideBar.dart';
import 'package:flutter_login_page/src/features/authentication/screens/showData/showData.dart';
import 'package:get/get.dart';
import '../../controllers/SidebarController/sidebarController.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // final sidebarController = Get.find<SidebarController>();

    final SidebarController _sidebarController = Get.find<SidebarController>();

    return Scaffold(
      drawer: Sidebar(
        name: _sidebarController.name.value,
        email: _sidebarController.email.value,
        password: _sidebarController.password.value,
        contact: _sidebarController.contact.value,
      ),
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10, top: 7),
            child: IconButton(
              onPressed: () {},
              icon: const Image(
                image: AssetImage("assets/images/dash.png"),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome to Dashboard",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Showdata()),
                );
              },
              child: Text(
                "Show Data",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
