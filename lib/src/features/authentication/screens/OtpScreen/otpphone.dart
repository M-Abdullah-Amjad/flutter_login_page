
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page/global/common/toast.dart';
import 'package:flutter_login_page/src/features/authentication/screens/Dashboard/Dashboard.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPPhone extends StatelessWidget{
  String verificationid;
  OTPPhone({super.key,required this.verificationid});


  TextEditingController otpController = TextEditingController();
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 40,),
              Text("CODE",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 60)),
              Text("Verification",style: TextStyle(
                  fontSize: 20
              ),),
              SizedBox(height: 30,),
              Text("Enter the verification code sent on the given phone number : ",style: TextStyle(
                  fontSize: 15
              ),),
              SizedBox(height: 30,),


              // OtpTextField(
              //   numberOfFields: 6,
              //   fillColor: Colors.black.withOpacity(0.1),
              //   filled: true,
              //   onSubmit: (code){
              //     print("OTP is => $code ");
              //   },
              // ),

              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter the OTP",
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25)
                  )
                ),
              )
,
              SizedBox(height: 40,),
              ElevatedButton(onPressed: ()async{

                // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> OTPScreen()));

                try{
                  PhoneAuthCredential credential = await PhoneAuthProvider.credential(
                      verificationId: verificationid,
                      smsCode: otpController.text.toString());
                    FirebaseAuth.instance.signInWithCredential(credential).then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
                    });
                }catch(ex){
                  showToast(message: "${ex}");
                }
              },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: SizedBox(
                      width: double.infinity,
                      child: Center(child: Text("CONFIRM",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),))))

            ],
          ),
        ),
      ),
    );
  }

}