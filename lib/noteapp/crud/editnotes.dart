import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../component/alert.dart';

class EditNotes extends StatefulWidget {
  //* it need both
  final docid; //! to deal with certain note id
  final list; //! use this list to pass all valueof notes, used as initial value inside TFF
  EditNotes({Key? key, this.docid, this.list}) : super(key: key);

  @override
  _EditNotesState createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");

  Reference? ref;

  File? file;

  var title, note, imageurl;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  editNotes(context) async {
    var formdata = formstate.currentState;

    //* user already add image on add page
    //* here we care about is he edit image or not
    //* [1] file == null == not edit image
    //! just update title, notes => no need to upload image =======
    if (file == null) {
      if (formdata!.validate()) {
        showLoading(context);
        formdata.save();

        //! we need access certain doc id
        //? then update its data
        //* may use set rather than update
        await notesref.doc(widget.docid).update({
          "title": title,
          "note": note,
          //! we not update uid ==========================================
          //* ==========handle error by => then && catchError =============
        }).then((value) {
          Navigator.of(context).pushNamed("homepage");
        }).catchError((e) {
          print("$e");
        });
      }
    }
    //* [2] else == file != null == edit image
    else {
      //! if null add new one by using => doc.update
      if (formdata!.validate()) {
        showLoading(context);
        formdata.save();

        //! update title, notes => upload image
        //* upload imagepart
        await ref!.putFile(file!);
        imageurl = await ref!.getDownloadURL();

        //* update all data
        await notesref.doc(widget.docid).update({
          "title": title,
          "note": note,
          "imageurl": imageurl,
          //! we not update uid ==========================================
          //* ==========handle error by => then && catchError =============
        }).then((value) {
          Navigator.of(context).pushNamed("homepage");
        }).catchError((e) {
          print("$e");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: Container(
          child: Column(
        children: [
          Form(
            key: formstate,
            child: Column(children: [
              //?======== title ===============
              TextFormField(
                //! ================== use list as initial value ==============
                //? ========= so we can display data notes here ==============
                initialValue: widget.list['title'],
                validator: (val) {
                  if (val!.length > 30) {
                    return "Title can't to be larger than 30 letter";
                  }
                  if (val.length < 2) {
                    return "Title can't to be less than 2 letter";
                  }
                  return null;
                },
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
              //?======== note ===============
              TextFormField(
                //! ================== use list as initial value ==============
                //? ========= so we can display data notes here ==============
                initialValue: widget.list['note'],
                validator: (val) {
                  if (val!.length > 255) {
                    return "Notes can't to be larger than 255 letter";
                  }
                  if (val.length < 10) {
                    return "Notes can't to be less than 10 letter";
                  }
                  return null;
                },
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
              //?======== add image ===============
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
                  "Edit Image For Note",
                  style: TextStyle(color: Colors.amber),
                ),
              ),
              //?======== edit btn ===============
              TextButton(
                onPressed: () async {
                  await editNotes(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.pink,
                  backgroundColor: Colors.pink,
                  iconColor: Colors.pink,
                ),
                // textColor: Colors.white,
                // padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  child: Text(
                    "Edit Note",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ]),
          ),
        ],
      )),
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
                  "Edit Image",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                //? =============== from GALLARY ==================
                InkWell(
                  onTap: () async {
                    var picked = await ImagePicker()
                        // .getImage(source: ImageSource.gallery);
                        .pickImage(source: ImageSource.gallery);
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
