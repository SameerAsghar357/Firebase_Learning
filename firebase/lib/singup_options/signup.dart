// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase/singup_options/login.dart';
import 'package:firebase/Utils/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  bool loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils();
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.alternate_email),
                      hintText: 'Email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email cannot be Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password cannot be Empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.deepPurple),
                ),
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    await _auth
                        .createUserWithEmailAndPassword(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString(),
                        )
                        .then((value) {
                          setState(() {
                            loading = false;
                          });
                        })
                        .onError((error, stackTrace) {
                          setState(() {
                            loading = false;
                          });
                          utils.toastmessage(error.toString());
                        });
                  }
                },
                // backgroundColor: Colors.deepPurple,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadiusGeometry.circular(10),
                // ),
                child:
                    loading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('SignUp', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
