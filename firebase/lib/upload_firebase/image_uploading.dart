import 'dart:io';

import 'package:firebase/custom_widgets/rounded_Button.dart';
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

class HomePage extends StatelessWidget {
  HomePage({super.key});

  File? image;
  var image_picker = ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 80,
  );

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
                Image.file(image!.absolute);
              },
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  // color: Colors.amber,
                  border: Border.all(color: Colors.black),
                ),
                child: Center(child: Icon(Icons.image)),
              ),
            ),
          ),
          SizedBox(height: 50),
          RoundedButton(
            title: 'Upload',
            loading: false,
            onTap: () {
              debugPrint('Hello');
            },
          ),
        ],
      ),
    );
  }
}
