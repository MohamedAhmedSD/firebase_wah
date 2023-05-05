import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../component/alert.dart';

class AddNotes extends StatefulWidget {
  AddNotes({Key? key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  //* we need to add our data into collection inside FireStore
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");

  //* Represents a reference to a Google Cloud Storage object.
  //? Developers can upload, download, and delete objects,
  //* as well as get/set object metadata.
  Reference? ref;

  //* A File holds a [path] on which operations can be performed.
  //? You can get the parent directory of the file using [parent],
  //* a property inherited from [FileSystemEntity].
  File? file;

  //* what we add them later
  var title, note, imageurl;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  //* method
  addNotes(context) async {
    if (file == null)
      return AwesomeDialog(
          context: context,
          title: "هام",
          body: Text("please choose Image"),
          dialogType: DialogType.error)
        ..show();

    //* cLL user state
    var formdata = formstate.currentState;
    //*
    if (formdata!.validate()) {
      //* loading
      showLoading(context);
      //* save current state
      formdata.save();

      //* upload inside your path this path
      await ref!.putFile(file!);
      //* get path of url that uploaded
      imageurl = await ref!.getDownloadURL();

      //* add data to certain fields with random doc id
      await notesref.add({
        "title": title,
        "note": note,
        "imageurl": imageurl,
        //! we get user id from auth
        "userid": FirebaseAuth.instance.currentUser!.uid
      }).then((value) {
        //* after end go to => homepage
        Navigator.of(context).pushNamed("homepage");
      }).catchError((e) {
        print("$e");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: formstate,
              child: Column(children: [
                //? ========= title ===============
                TextFormField(
                  validator: (val) {
                    if (val!.length > 30) {
                      return "Title can't to be larger than 30 letter";
                    }
                    if (val.length < 2) {
                      return "Title can't to be less than 2 letter";
                    }
                    return null;
                  },
                  //? === save them =====
                  onSaved: (val) {
                    title = val;
                  },
                  maxLength: 30,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Title Note",
                      prefixIcon: Icon(Icons.note)),
                ),
                //? ========= notes ===============
                TextFormField(
                  validator: (val) {
                    if (val!.length > 255) {
                      return "Notes can't to be larger than 255 letter";
                    }
                    if (val.length < 10) {
                      return "Notes can't to be less than 10 letter";
                    }
                    return null;
                  },
                  //? === save them =====
                  onSaved: (val) {
                    note = val;
                  },
                  minLines: 1,
                  maxLines: 3,
                  maxLength: 200,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Note",
                      prefixIcon: Icon(Icons.note)),
                ),
                //? ========= showBottomSheet => to add image ===============
                TextButton(
                  onPressed: () {
                    showBottomSheet(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.pink,
                    backgroundColor: Colors.pink,
                    iconColor: Colors.pink,
                  ),
                  // textColor: Colors.white,
                  child: Text(
                    "Add Image For Note",
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
                //?============= add btn ================
                TextButton(
                  onPressed: () async {
                    await addNotes(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.pink,
                    backgroundColor: Colors.pink,
                    iconColor: Colors.pink,
                  ),
                  // textColor: Colors.white,
                  // padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 10),
                    child: Text(
                      "Add Note",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  showBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please Choose Image",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                //? =============== from GALLARY ==================
                InkWell(
                  onTap: () async {
                    //! picked image ====================================
                    var picked = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    // .getImage(source: ImageSource.gallery);
                    if (picked != null) {
                      //* ===== to get only image name => .path ===
                      file = File(picked.path);
                      //* === add random number to its start
                      //* to avoid repeataion on img name
                      var rand = Random().nextInt(100000);
                      //* basename => need path lib ======
                      var imagename = "$rand" + basename(picked.path);
                      //* we can use child to divide our path ====
                      ref = FirebaseStorage.instance
                          .ref("images")
                          .child("$imagename");
                      //* after end close dialogr
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo_outlined,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "From Gallery",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),
                ),
                //? =============== from CAMERA ==================
                //* may we need to give permissions or try different emulator ===
                InkWell(
                  onTap: () async {
                    var picked = await ImagePicker()
                        // .getImage(source: ImageSource.camera);
                        .pickImage(source: ImageSource.camera);
                    if (picked != null) {
                      file = File(picked.path);
                      var rand = Random().nextInt(100000);
                      var imagename = "$rand" + basename(picked.path);
                      ref = FirebaseStorage.instance
                          .ref("images")
                          .child("$imagename");
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "From Camera",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),
                ),
              ],
            ),
          );
        });
  }
}
