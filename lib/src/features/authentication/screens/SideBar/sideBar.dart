import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page/src/features/authentication/screens/login_screen/LoginPage.dart';
import 'package:flutter_login_page/src/features/authentication/screens/logout/logout.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../global/common/toast.dart';
import '../../controllers/SidebarController/sidebarController.dart';

class Sidebar extends StatefulWidget {
  final sidebarController = Get.find<SidebarController>();
  final String email;
  final String password;
  final String name;
  final String contact;

  Sidebar({
    required this.name,
    required this.email,
    required this.contact,
    required this.password,
  });

  
  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  File? imagePicked;
  final SidebarController _sidebarController = Get.find<SidebarController>();
@override
  void initState() {
    _sidebarController.fetchUserData(widget.email);
  }
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(widget.name, style: TextStyle(color: Colors.white)),
            accountEmail: Text(widget.email, style: TextStyle(color: Colors.white)),
            currentAccountPicture: InkWell(
              onTap: showAlertBox,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: imagePicked != null
                    ? FileImage(imagePicked!)
                    : imageUrl != null
                    ? NetworkImage(imageUrl!) as ImageProvider
                    : null,
                child: imagePicked == null && imageUrl == null ? const Icon(Icons.person) : null,
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/img_6.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.call),
            title: Text("Contact number: ${widget.contact}"),
          ),
          ListTile(
            leading: const Icon(Icons.password),
            title: Text("Password: ${widget.password}"),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favourite"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications_active),
            title: const Text("Notifications"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Setting"),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Log Out"),
            onTap: () {
              logoutUser(context);
              showToast(message: "Successfully Logged Out");
            },
          ),
        ],
      ),
    );
  }

  void showAlertBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pick Image From"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.camera);
                },
                title: const Text("Camera"),
                leading: const Icon(Icons.camera_alt),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  pickImage(ImageSource.gallery);
                },
                title: const Text("From Gallery"),
                leading: const Icon(Icons.photo),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo == null) return;
      final tempPhoto = File(photo.path);
      setState(() {
        imagePicked = tempPhoto;
      });
      await uploadImage(tempPhoto);
    } catch (e) {
      showToast(message: "Failed to pick image: $e");
      print("Error picking image: $e");
    }
  }

  Future<void> uploadImage(File image) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('Profile Pictures')
          .child(widget.email)
          .child('profile_picture.jpg');
      UploadTask uploadTask = ref.putFile(image);

      TaskSnapshot taskSnapshot = await uploadTask;
      final url = await taskSnapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = url;
      });

      await FirebaseFirestore.instance.collection('users').doc(widget.email).update({
        'profile_picture': url,
      });

      showToast(message: "Image uploaded successfully");
    } catch (e) {
      showToast(message: "Image upload failed: $e");
      print("Error uploading image: $e");
    }
  }
}
