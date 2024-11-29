import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profiepage extends StatelessWidget{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 70,

          ),
          SizedBox(height: 20,),
          TextField(
            controller: emailController,
            
          )
        ],
      ),
    );
  }

}