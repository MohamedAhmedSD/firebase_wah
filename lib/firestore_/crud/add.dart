//? add doc inside collection

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

//* read => https://firebase.flutter.dev/docs/firestore/usage/

class _AddState extends State<Add> {
//? ==================== add with random doc id  =============
  addDocToCollection() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");

    //! ==== add => after collection => no need to use doc ========
    //* this doc come with random ID ==============================
    //? Map to add to our data => K && V
    await userref.add({
      "name": "Ali",
      "Age": 7, //? is not work if end with , ??? ======
    });
  }

//? ==========add with certain doc id ================
//* ========== use doc(idddd).set({map of data}) ================

  addDocToCollectionWithCertainId() async {
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");

    await userref.doc("001").set({"name": "Ali", "Age": 7});
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
                  addDocToCollection();
                },
                child: Text("addDocToCollection"),
              ),
            ),
            //? ========== order ================
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  addDocToCollectionWithCertainId();
                },
                child: Text("addDocToCollectionWithCertainId"),
              ),
            ),
          ],
        ));
  }
}
