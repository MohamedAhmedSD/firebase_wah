//? we can do all Cruds on it just determain where is our collection

//? Nested collection inside doc

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Nested extends StatefulWidget {
  @override
  _NestedState createState() => _NestedState();
}

//* read => https://firebase.flutter.dev/docs/firestore/usage/

class _NestedState extends State<Nested> {
//? ==================== Nested =============
  nested() async {
    //* collection inside doc
    CollectionReference userref = FirebaseFirestore.instance
        .collection("users_")
        .doc("002")
        .collection("address");

    await userref
        .doc("001")
        .set({"Country": "Iraq"}, SetOptions(merge: true)).then((value) {
      print("set success");
    }).catchError((e) {
      print(e);
    });
  }

//? ========== we can use then and catch on all CRUDs ================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cloud firestore'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //? ========== Nested ================

            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  nested();
                },
                child: Text("Nested"),
              ),
            ),
          ],
        ));
  }
}
