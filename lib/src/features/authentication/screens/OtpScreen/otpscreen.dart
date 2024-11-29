
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPScreen extends StatelessWidget{
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("CODE",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 60)),
              Text("Verification",style: TextStyle(
                fontSize: 20
              ),),
              SizedBox(height: 30,),
              Text("Enter the verification code sent on the email: muhammadabdullahamjad6@gmail.com",style: TextStyle(
                  fontSize: 15
              ),),
              SizedBox(height: 30,),
              OtpTextField(
                numberOfFields: 6,
                fillColor: Colors.black.withOpacity(0.1),
                filled: true,
                onSubmit: (code){
                  print("OTP is => $code ");
                },
              ),
              SizedBox(height: 40,),
              ElevatedButton(onPressed: (){

                // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> OTPScreen()));

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