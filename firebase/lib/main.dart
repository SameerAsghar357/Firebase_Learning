// ignore_for_file: unused_import, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase/UI/SplashScreen.dart';
import 'package:firebase/singup_options/login.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, // Add this line
    );
    debugPrint('Firebase initialization successfull');
  } catch (e, stack) {
    print('Firebase initialization error: $e');
    print('Stack trace: $stack');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.white),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(iconColor: WidgetStateProperty.all(Colors.white)),
        ),
        appBarTheme: AppBarTheme(
          // color: Colors.deepPurple,
          backgroundColor: Colors.deepPurple,
        ),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),

      home: Splashscreen(),
    );
  }
}

// SHA1 OR SHA256 Keys Generating Code:
// keytool -list -v -keystore "C:\Users\Sameer\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApplication());
// }

// class MyApplication extends StatelessWidget {
//   const MyApplication({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
//       home: HomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => HomePageState();
// }

// class HomePageState extends State<HomePage> {
//   int counter = 0;

//   void callback() {
//     setState(() {
//       counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text('HomePage', style: TextStyle(color: Colors.white)),
//         elevation: 10,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('You have pushed this button this many times:'),
//             Text("$counter", style: TextStyle(fontSize: 30)),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         // onPressed: () => callback(),
//         onPressed: () {
//           setState(() {
//             counter++;
//           });
//         },
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
