import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Utils/utils.dart';
import 'package:firebase/custom_widgets/rounded_Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class addFirestoreDataScreen extends StatefulWidget {
  const addFirestoreDataScreen({super.key});

  @override
  State<addFirestoreDataScreen> createState() => _addFirestoreDataScreenState();
}

class _addFirestoreDataScreenState extends State<addFirestoreDataScreen> {
  bool loading = false;
  final textController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Firestore Add Data Screen',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: TextFormField(
              controller: textController,
              maxLines: 6,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),

          RoundedButton(
            loading: loading,
            title: 'Add Post',
            onTap: () {
              String id = DateTime.now().millisecondsSinceEpoch.toString();
              setState(() {
                loading = true;
              });
              firestore
                  .doc(id)
                  .set({'title': textController.text.toString(), 'id': id})
                  .then((value) {
                    setState(() {
                      loading = false;
                    });

                    Utils().toastmessage('Done');
                  })
                  .onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastmessage(error.toString());
                  });
            },
          ),
        ],
      ),
    );
  }
}
