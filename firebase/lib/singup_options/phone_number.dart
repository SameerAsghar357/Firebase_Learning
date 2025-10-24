// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase/UI/SplashScreen.dart';
import 'package:firebase/singup_options/code_verification.dart';
import 'package:firebase/Utils/utils.dart';
import 'package:firebase/custom_widgets/rounded_Button.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final PhoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'Number Verification',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Form(
              key: formkey,
              child: TextFormField(
                controller: PhoneNumberController,
                decoration: InputDecoration(hintText: "Phone Number"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field cannot be empty";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            SizedBox(height: 30),
            RoundedButton(
              title: "Continue",
              loading: loading,
              onTap: () {
                if (formkey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });

                  auth.verifyPhoneNumber(
                    verificationCompleted: (_) {
                      setState(() {
                        loading = false;
                      });
                    },
                    phoneNumber: PhoneNumberController.text,
                    verificationFailed: (e) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastmessage(e.toString());
                    },
                    codeSent: (String verificationId, int? token) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => codeVerification(
                                verificationId: verificationId,
                              ),
                        ),
                      );
                      setState(() {
                        loading = false;
                      });
                    },
                    codeAutoRetrievalTimeout: (e) {
                      Utils().toastmessage(e.toString());
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
