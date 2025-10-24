import 'package:firebase/realtime_database/addpostScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase/singup_options/login.dart';
import 'package:firebase/Utils/utils.dart';

class Postscreen extends StatefulWidget {
  const Postscreen({super.key});

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchController = TextEditingController();
  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Screen', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            tooltip: 'SignOut',
            onPressed: () {
              auth
                  .signOut()
                  .then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  })
                  .onError((error, stacktrace) {
                    Utils().toastmessage(error.toString());
                  });
            },
            icon: Icon(Icons.logout_outlined, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child('title').value.toString();
                final id = snapshot.child('id').value.toString();

                if (searchController.text.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.grey.shade600,
                        ),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              onTap: () {
                                showMyDialog('Update', title, id);
                              },
                              child: ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                ref
                                    .child(id)
                                    .remove()
                                    .then((onValue) {
                                      Utils().toastmessage('Removed');
                                    })
                                    .onError((error, stackTrace) {
                                      Utils().toastmessage(error.toString());
                                    });
                              },
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Delete'),
                              ),
                            ),
                          ];
                        },
                      ),
                    ),
                  );
                } else if (title.toString().toLowerCase().contains(
                  searchController.text.toLowerCase(),
                )) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.grey.shade600,
                        ),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              onTap: () {
                                showMyDialog('Update', title, id);
                              },
                              child: ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                ref
                                    .child(id)
                                    .remove()
                                    .then((onValue) {
                                      Utils().toastmessage('Removed');
                                    })
                                    .onError((error, stackTrace) {
                                      Utils().toastmessage(error.toString());
                                    });
                              },
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Delete'),
                              ),
                            ),
                          ];
                        },
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addpostscreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> showMyDialog(String title, String value, String id) async {
    editController.text = value;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextFormField(
            controller: editController,
            decoration: InputDecoration(hintText: value),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(title),
              onPressed: () {
                ref
                    .child(id)
                    .update({'title': editController.text.toString()})
                    .then((onValue) {
                      Navigator.pop(context);
                      Utils().toastmessage('Updated');
                    })
                    .onError((error, stackTrace) {
                      Utils().toastmessage(error.toString());
                    });
              },
            ),
          ],
        );
      },
    );
  }
}


//Column(
        // children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Column(
          //     children: [
          //       Text(
          //         'All Data in Firebase Database',
          //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          //       ),
          // SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('Stream Builder Way', style: TextStyle(fontSize: 18)),
          // ),
          // Expanded(
          //   child: StreamBuilder(
          //     stream: ref.onValue,
          //     builder: (context, snapshot) {
          //       if (!snapshot.hasData) {
          //         return Center(child: CircularProgressIndicator());
          //       } else {
          //         Map<dynamic, dynamic> map =
          //             snapshot.data!.snapshot.value as dynamic;
          //         List<dynamic> list = [];
          //         // list.add(map.values);
          //         list = map.values.toList();
          //         return ListView.builder(
          //           itemCount: snapshot.data!.snapshot.children.length,
          //           itemBuilder: (context, index) {
          //             return ListTile(
          //               title: Column(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(list[index]['title']),
          //                   Text(list[index]['id']),
          //                 ],
          //               ),
          //             );
          //           },
          //         );
          //       }
          //     },
          //   ),
          // ),

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     'Firebase Animated Builder Way',
          //     style: TextStyle(fontSize: 18),
          //   ),
          // ),

