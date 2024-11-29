import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page/src/features/authentication/screens/login_screen/LoginPage.dart';
import 'package:flutter_login_page/src/features/authentication/screens/signup/signup.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/SidebarController/sidebarController.dart';

class WelcomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
        //     gradient: LinearGradient(begin: Alignment.topRight,end: Alignment.bottomLeft,
        //         colors: [Colors.purple.shade400 ,Colors.blueAccent ])
        ),
        alignment: Alignment.center,
        child: Padding(

          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/images/m.png")),
              SizedBox(height: 50,),
              Text("Welcome",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              SizedBox(height: 10,),
              Text("Here, you can login and ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        Text("enter to our application",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: OutlinedButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                    },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(),
                              side: BorderSide(color: Colors.white),padding:
                                EdgeInsets.symmetric(vertical: 10)
                            )
                            ,child: Text("LOGIN",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                  ),
                  SizedBox(width: 20,),
                  Expanded(child: ElevatedButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> signup()));

                  },
              style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(),
              side: BorderSide(color: Colors.black),padding:
              EdgeInsets.symmetric(vertical: 10)
              ),child: Text("SIGNUP",style: TextStyle(color: Colors.black),)))
                ],
              )
            ],
          ),
        ),
      )
    );
  }

}