import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
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
        print(imgPicked.path); //! full path
        print('===================');

        //* ===== only img name ==============
        var imgName = basename(imgPicked.path); //* basename from => path lib
        print(imgName);

        //? == avoid repeat img name by using random number before it
        var random = Random().nextInt(10000000);
        //* assign it to start of img name => new name
        imgName = "$random$imgName";
        print(imgName);

        //! ========= how upload it to Storage ==========
        //* 1. make folder and inside it your img name
        //? If the [path] is empty, the reference will point to the root of the storage bucket.
        var refstorage = FirebaseStorage.instance.ref("images/$imgName");
        //? we can use child to divide our long path
        // var refstorage = FirebaseStorage.instance.ref("images").child("part1").child("$imgName");

        //* 2. Upload a [File] from the filesystem. The file must exist.
        await refstorage.putFile(file!);

        //* 3. to get link where our img upload on FB.Storage
        var url = refstorage.getDownloadURL();
        print('url: $url');

        //!==============================================
      } else {
        print("Please choose Image");
      }
      //! Hint: upload the image to Firebase Storage
    }
    // else {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text('Please grant access to the camera.'),
    //   ));
    // }
  }

//! === [ list => can determain its itemes number , listtAll => may reach to million]
//* use listOptions =======

  getImagesAndFolderName() async {
    //* [A] from root
    //* list here back future

    //
    var ref =
        await FirebaseStorage.instance.ref().list(ListOptions(maxResults: 2));
    // access its items
    //* [1] back files name
    ref.items.forEach((element) {
      print("==================");
      print(element.name);
    });

    //! items or prefixes

    //* [2] back folder name
    ref.prefixes.forEach((element) {
      print("==================");
      print(element.name);
    });
  }

  getImagesFromImagesFolder() async {
    //* [A] from certain folder
    // list here back future
    var ref = await FirebaseStorage.instance.ref("images").listAll();
    // access its items
    ref.items.forEach((element) {
      print("==================");
      print(element.name);
    });

    //* [2] back folder name
    ref.prefixes.forEach((element) {
      print("==================");
      print(element.name);
    });
  }

  @override
  void initState() {
    super.initState();
    getImagesAndFolderName();
    getImagesFromImagesFolder();
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
