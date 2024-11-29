import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final String name;
  final String contact;
  final String password;

  const UserProfile({
    super.key,
    required this.name,
    required this.contact,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name', style: const TextStyle(fontSize: 20)),
            Text('Contact: $contact', style: const TextStyle(fontSize: 20)),
            Text('Password: $password', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
