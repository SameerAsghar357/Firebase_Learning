import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Utils/utils.dart';
import 'package:firebase/firestore_database/add_firestore_data.dart';
import 'package:flutter/material.dart';

class FirestoreListScreen extends StatefulWidget {
  const FirestoreListScreen({super.key});

  @override
  State<FirestoreListScreen> createState() => _FirestoreListScreenState();
}

class _FirestoreListScreenState extends State<FirestoreListScreen> {
  final textController = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('firestore list', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: firestore,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Some Error'));
          } else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data!.docs[index]['title'].toString()),
                  subtitle: Text(snapshot.data!.docs[index].id.toString()),
                  trailing: PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: Colors.grey),
                    tooltip: 'Options Menu',
                    itemBuilder: (context) {
                      String id = snapshot.data!.docs[index].id.toString();
                      String data =
                          snapshot.data!.docs[index]['title'].toString();
                      return [
                        PopupMenuItem(
                          onTap: () {
                            myDialog('Update', data, id);
                          },
                          child: ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('Edit'),
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            ref.doc(id).delete();
                          },
                          child: ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('Delete'),
                          ),
                        ),
                      ];
                    },
                  ),
                );
              },
            );
          }
        },
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
                if (title == "Update") {
                  ref
                      .doc(id)
                      .update({'title': textController.text.toString()})
                      .then((value) {
                        Navigator.pop(context);
                        Utils().toastmessage('Updated');
                      })
                      .onError((error, stackTrace) {
                        Utils().toastmessage(error.toString());
                      });
                }
              },
              child: Text(title),
            ),
          ],
        );
      },
    );
  }
}
