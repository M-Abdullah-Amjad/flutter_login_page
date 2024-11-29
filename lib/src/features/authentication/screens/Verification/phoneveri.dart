import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page/global/common/toast.dart';
import 'package:flutter_login_page/src/features/authentication/screens/OtpScreen/otpphone.dart';

class PhoneVerification extends StatelessWidget {

  TextEditingController phoneController = TextEditingController(text: "+92 ");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Icon(Icons.password, size: 150),
              const SizedBox(height: 20),
              const Text(
                "Forget Password",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "Enter your Phone No. below: ",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 35),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: "Phone No.",
                  labelText: "Phone No.",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  String phoneNumber = phoneController.text.trim();

                  if (phoneNumber.isEmpty || phoneNumber == "+92") {
                    showToast(message: "Please enter the contact number");
                    return;
                  } else if(phoneNumber.length != 10){
                    showToast(message: "Digits are not complete check it!");
                  }else if(phoneNumber.length > 10){
                    showToast(message: "Digits are more then 11 limit check it!");
                  }

                  try {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      verificationCompleted: (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException ex) {},
                      codeSent: (String verificationId, int? resendToken) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OTPPhone(verificationid: verificationId),
                          ),
                        );
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                      phoneNumber: phoneNumber,
                    );
                  } catch (e) {
                    showToast(message: "Error: ${e.toString()}");
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "VERIFY YOUR OTP",
                      style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
