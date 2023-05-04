import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MyStorage extends StatefulWidget {
  @override
  _MyStorageState createState() => _MyStorageState();
}

//! ============ we use Storage to deal with files && images ===============
//* Sometimes Camera not work on your emulator, so test them on others or in
//* your physical phone

class _MyStorageState extends State<MyStorage> {
  //? ==== image picker, need File path ===========
  File? file; //* as dart:io => input/output not math
  var imagePicker = ImagePicker();

  //? ===== upload img , async =========
  uploadImage() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request();
      status = await Permission.camera.status;
    }
    if (status.isGranted) {
      var imgPicked = await imagePicker.pickImage(source: ImageSource.camera);
      //
      if (imgPicked != null) {
        file = File(imgPicked.path);
        print('===================');
        print(imgPicked.path);
      } else {
        print("Please choose Image");
      }
      //! Hint: upload the image to Firebase Storage
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please grant access to the camera.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyStorage'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: ElevatedButton(
              onPressed: () async {
                await uploadImage();
              },
              child: Text("Upload Image"),
            ))
          ],
        ));
  }
}
