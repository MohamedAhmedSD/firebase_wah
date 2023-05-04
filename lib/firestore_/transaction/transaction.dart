//?== if field transaction => all process field , should all done or no one
//* as when you update facebook user name, all posts should Ui have new username
//* it update last data on server, so first read then write

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

//* read => https://firebase.flutter.dev/docs/firestore/usage/

class _TransactionState extends State<Transaction> {
//? ==================== Transaction can use CRUDs=============

  //* doc not collection, and out scope of function
  DocumentReference docref =
      FirebaseFirestore.instance.collection("users_").doc("002");

  trans() async {
    //! ==== Transaction =>is future function, so we see 2 async ========

    //* call transaction
    FirebaseFirestore.instance.runTransaction((transaction) async {
      //  start

      // DocumentSnapshot docsnap = await transaction.get(documentReference);
      DocumentSnapshot docsnap = await transaction.get(docref);

      //  should use conditional before deal with CRUD to handle errors
      if (docsnap.exists) {
        // transaction.update(documentReference, data);
        transaction.update(docref, {"phone": 23456});
      }
      // end
    });
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
                  trans();
                },
                child: Text("Transaction"),
              ),
            ),
          ],
        ));
  }
}
