//? Update doc inside collection

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  @override
  _UpdateState createState() => _UpdateState();
}

//* read => https://firebase.flutter.dev/docs/firestore/usage/

class _UpdateState extends State<Update> {
  
//! ============= Update or Set ======================
//* if doc id not found => update == error, Set == build it for you
//* update it refresh certain data without delete them
//? set it delete old doc and make new one with new value
//* set with set options, to just rebuild only certain data == update
//! ============= Update or Set ======================

//? ==================== doc(id).Update =============
  update() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");

    await userref.doc("001").update({
      "name": "Mohamed",
      "Age": 32,
    });
  }

//? ========== doc(id).set ================

  set() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");

    await userref.doc("002").set({
      "name": "Mohamed",
      "Age": 32,
    });
  }
  //? ========== doc(id).set , SetOptions(merge: true) ================

  setAndSetOptions() async {
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");

    await userref.doc("001").set({
      "name": "Ali",
    }, SetOptions(merge: true));
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
            //? ========== update ================

            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  update();
                },
                child: Text("update"),
              ),
            ),
            //? ========== set ================
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  set();
                },
                child: Text("set"),
              ),
            ),
            //? ========== set & SetOptions================
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  setAndSetOptions();
                },
                child: Text("setAndSetOptions"),
              ),
            ),
          ],
        ));
  }
}
