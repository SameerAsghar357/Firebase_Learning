import 'dart:io';

import 'package:firebase/Utils/utils.dart';
import 'package:firebase/custom_widgets/rounded_Button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadingScreen extends StatelessWidget {
  const ImageUploadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey, useMaterial3: true),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  bool flag = false;
  var image_picker = ImagePicker();
  var imageUrl;

  // final storage = FirebaseStorage.instance.ref().child('/images');
  Future<void> getGalleryImage(BuildContext context) async {
    final picked_file = await image_picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    setState(() {
      flag = true;
    });

    if (picked_file != null) {
      _image = File(picked_file.path);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.lightGreen),
              SizedBox(width: 20),
              Text('Image Selected Succesfully'),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.dangerous, color: Colors.red),
              SizedBox(width: 20),
              Text('No Image Selected'),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> uploadImage() async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child(
        'images/${DateTime.now().microsecondsSinceEpoch}.png',
      );
      await ref.putFile(_image!.absolute).then((value) {
        Utils().toastmessage('Image Uploaded Succesfully');
      });
      imageUrl = await ref.getDownloadURL();
    } catch (e) {
      Utils().toastmessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Image Uploading Screen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 1,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                getGalleryImage(context);
              },
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  // color: Colors.amber,
                  border: Border.all(color: Colors.black),
                ),
                child:
                    imageUrl != null
                        ? Image.network(imageUrl)
                        : Center(child: Icon(Icons.image)),
              ),
            ),
          ),
          SizedBox(height: 50),
          RoundedButton(
            title: 'Upload',
            loading: false,
            onTap: () {
              uploadImage();
            },
          ),
        ],
      ),
    );
  }
}
