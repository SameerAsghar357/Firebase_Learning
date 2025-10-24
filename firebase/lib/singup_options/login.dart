import 'package:flutter/material.dart';
import 'package:firebase/singup_options/phone_number.dart';
import 'package:firebase/realtime_database/postScreen.dart';
import 'package:firebase/singup_options/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/Utils/utils.dart';
import 'package:firebase/custom_widgets/rounded_Button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            RoundedButton(
              title: 'Login',
              loading: loading,
              onTap: () {
                if (formkey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  auth
                      .signInWithEmailAndPassword(
                        email: emailController.text.toString(),
                        password: passwordController.text.toString(),
                      )
                      .then((value) {
                        setState(() {
                          loading = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Postscreen()),
                        );
                      })
                      .onError((error, stackTrace) {
                        setState(() {
                          loading = false;
                        });
                        utils.toastmessage(error.toString());
                      });
                }
              },
            ),
            // Container(
            //   height: 50,
            //   decoration: BoxDecoration(
            //     color: Colors.deepPurple,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Center(
            //     child:
            //         loading
            //             ? CircularProgressIndicator(color: Colors.white)
            //             : Text('Login', style: TextStyle(color: Colors.white)),
            //   ),
            // ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text('SignUp'),
                ),
              ],
            ),
            SizedBox(height: 30),
            InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhoneNumberScreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.black),
                ),
                child: Center(child: Text('Login with Phone Number')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
