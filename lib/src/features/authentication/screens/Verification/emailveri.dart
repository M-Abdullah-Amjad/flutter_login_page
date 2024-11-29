import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page/src/features/authentication/screens/OtpScreen/otpscreen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EmailVerification extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context,false);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Icon(Icons.password,size: 150,),
              SizedBox(height: 20,),
              Text("Forget Password",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("Enter your Email below: ",style: TextStyle(fontSize: 20),),
              SizedBox(height: 35,),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_outlined),
                    hintText: "Email",
                    labelText: "Email",
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 40,),
              ElevatedButton(onPressed: (){

                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> OTPScreen()));

              },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: SizedBox(
                      width: double.infinity,
                      child: Center(child: Text("NEXT",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),))))
            ],
          ),
        ),
      ),
    );
  }

}