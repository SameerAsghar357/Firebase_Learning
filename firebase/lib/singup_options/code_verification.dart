// ignore_for_file: unused_import, camel_case_types, must_be_immutable

import 'package:firebase/Utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase/UI/SplashScreen.dart';
import 'package:firebase/custom_widgets/rounded_Button.dart';

class codeVerification extends StatefulWidget {
  String? verificationId;
  codeVerification({super.key, required this.verificationId});

  @override
  State<codeVerification> createState() => _codeVerificationState();
}

class _codeVerificationState extends State<codeVerification> {
  final codeVerificationController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text('Code Verification', style: TextStyle(color: Colors.white)),
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
                controller: codeVerificationController,
                decoration: InputDecoration(hintText: "Verify 6 digit code"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field cannot be empty";
                  } else {
                    return "";
                  }
                },
              ),
            ),

            SizedBox(height: 30),
            RoundedButton(
              loading: loading,
              title: "Verify",
              // loading: false,
              onTap: () {
                setState(() {
                  loading = false;
                });
                final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId.toString(),
                  smsCode: codeVerificationController.text.toString(),
                );
                try {
                  auth.signInWithCredential(credential);
                } catch (e) {
                  Utils().toastmessage(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
