
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_page/src/features/authentication/screens/onBoardingScreens/onBoardingScreen.dart';

import '../welcome_screen/welcome_screen.dart';

class splash_screen extends StatefulWidget{
  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {

  bool animate = false;

  @override
  void initState(){
    startAnimation();
  }
  Widget build( context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topRight,end: Alignment.bottomLeft,
              colors: [Colors.purple.shade400 ,Colors.blueAccent ])
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
                top: animate ? 0: -30,
                left: animate ? 0: -30,
                child: const Image(image:AssetImage("assets/images/im3.png"),height: 100,width: 100,)),

            Column(
              children: [
                const SizedBox(height: 150,),
                Container(

                  color: Colors.brown,
                  child: const Column(
                    children: [
                      Text("Welcome to ",style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,fontWeight: FontWeight.bold,
                      ),),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Login ",style: TextStyle(
                              color: Colors.red,
                              fontSize: 45,fontWeight: FontWeight.bold
                          ),),
                          Text("Application",style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30,fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AnimatedPositioned(
                 duration: const Duration(milliseconds: 1600),
                 top: animate ? 370: -30,
                 left: animate ? 70: -30,
                 child: const Image(image: AssetImage("assets/images/im2.png"))),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 1600),
                right: animate ? 10: -30,
                bottom: animate ? 10: -30,
                child: const Image(image: AssetImage("assets/images/im1.png"),height: 90,width: 90,))
          ],
        ),
      ),
    );
  }

  Future startAnimation() async{
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      animate = true;
    });
    await Future.delayed(const Duration(milliseconds: 5000));
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }
}