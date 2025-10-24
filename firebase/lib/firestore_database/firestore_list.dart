import 'package:firebase_practice/firestore_database/add_firestore_data.dart';
import 'package:flutter/material.dart';

class FirestoreListScreen extends StatefulWidget {
  const FirestoreListScreen({super.key});

  @override
  State<FirestoreListScreen> createState() => _FirestoreListScreenState();
}

class _FirestoreListScreenState extends State<FirestoreListScreen> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('firestore list', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),

      body: Expanded(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(title: Text('ASIF'));
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Center(child: Icon(Icons.add)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addFirestoreDataScreen()),
          );
        },
      ),
    );
  }

  Future<dynamic> myDialog(String title, String data, String id) async {
    textController.text = data;
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextFormField(
            controller: textController,
            // decoration: InputDecoration(hintText: data),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (title == "Update") {}
              },
              child: Text(title),
            ),
          ],
        );
      },
    );
  }
}
