// ignore_for_file: unused_import
import 'dart:async';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase/singup_options/login.dart';
import 'package:firebase/UI/Services/splash_services.dart';
import 'package:firebase/Utils/utils.dart';
import 'package:firebase/custom_widgets/rounded_Button.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  SplashServices splashServices = SplashServices();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.login(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter HomePage', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 1,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Firebase Tutorials', style: TextStyle(fontSize: 30)),
              SizedBox(height: 20),
              // splashScreenButton(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: RoundedButton(
                  title: 'Next->',
                  loading: loading,
                  onTap: () {
                    setState(() {
                      loading = true;
                    });
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // ).whenComplete(() {
                    //   setState(() {
                    //     loading = false;
                    //   });
                    // });
                    splashServices.login(context).whenComplete(() {
                      Timer(
                        Duration(seconds: 1),
                        () => setState(() {
                          loading = false;
                        }),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class splashScreenButton extends StatefulWidget {
//   const splashScreenButton({super.key});

//   // bool loading = false;

//   @override
//   State<splashScreenButton> createState() => _splashScreenButtonState();
// }

// bool loading = false;

// class _splashScreenButtonState extends State<splashScreenButton> {
//   void timerfunction() {
//     Timer(
//       Duration(seconds: 1),
//       () => setState(() {
//         loading = false;
//       }),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 40),
//       child: InkWell(
//         onTap: () {
//           setState(() {
//             loading = true;
//           });
//           SplashServices().login(context);
//           setState(() {
//             timerfunction();
//           });
//         },
//         child: RoundedButton(
//           // loading: loading,
//           title: "Next ->",
//         onTap: () {},
//           // onPressed: () {
//           //   setState(() {
//           //     widget.loading = true;
//           //   });
//           //   SplashServices().login(context);
//           // setState(() {
//           // timerfunction();
//           // });
//           // timerfunction();
//           // },

//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(builder: (context) => LoginPage()),
//           // );
//           // child: widget.loading ? CircularProgressIndicator() : Text('Next ->'),
//         ),
//       ),
//     );
//   }
// }
