//?== if field BatchAndWrote => all process field , should all done or no one
//* as when you update facebook user name, all posts should Ui have new username
//* it update last data on server, so first read then write

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BatchAndWrote extends StatefulWidget {
  @override
  _BatchAndWroteState createState() => _BatchAndWroteState();
}

//* read => https://firebase.flutter.dev/docs/firestore/usage/

class _BatchAndWroteState extends State<BatchAndWrote> {
//? ==================== Batch Write => multiple CRUD on at one time =============
//* get == read , others are write
//* all done or no one

  //* collection, and out scope of function
  CollectionReference users = FirebaseFirestore.instance.collection("users_");
  //* may for doc
  DocumentReference doc1 = FirebaseFirestore.instance
      .collection("users_")
      .doc("ethI1r2CVqWZHHyyxixU");
  DocumentReference doc2 = FirebaseFirestore.instance
      .collection("users_")
      .doc("6ZfHkphjkdiSJE99NNCl");

  batchWrite() async {
    //! ==== batch ========
    //* delete doc1 && update doc2

    //* WriteBatch
    WriteBatch batch = FirebaseFirestore.instance.batch();
    //* delete
    batch.delete(doc1);
    //*update
    // batch.update(document, data)
    batch.update(doc2, {"class": "A"});

    //! we need commit to work ==============
    batch.commit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cloud firestore'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  batchWrite();
                },
                child: Text("Batch"),
              ),
            ),
          ],
        ));
  }
}
