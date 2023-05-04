//? then == after process end do these things

//? Delete doc inside collection

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Delete extends StatefulWidget {
  @override
  _DeleteState createState() => _DeleteState();
}

//* read => https://firebase.flutter.dev/docs/firestore/usage/

class _DeleteState extends State<Delete> {
//? ==================== Delete =============
  delete() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");

    await userref.doc("001").delete().then((value) {
      print("Delete success");
    }).catchError((e) {
      //! ========== catchError(function(){}) ================

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
            //? ========== Delete ================

            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  delete();
                },
                child: Text("Delete"),
              ),
            ),
          ],
        ));
  }
}
