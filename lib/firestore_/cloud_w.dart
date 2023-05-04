import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
//? ==================== call certain collection data  =============
//* we can use var till learn data type we deal with it
//! get == Future == need await

  getDataOfCollectionShortWay() {
    //! [1] short way
    var userref = FirebaseFirestore.instance
        .collection("users_") // CollectionReference
        .get() // QuerySnapshot
        .then((value) => {
              value.docs.forEach((element) {
                // QueryDocumentSnapshot

                print(element.data());
                print("====================");
              })
            }); // QuerySnapshot
  }

  getDataOfCollection() async {
    //! [2] make them on pieces
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");
    //* get
    //! get == Future == need await

    QuerySnapshot querySnapshot = await userref.get();
    //* docs
    List<QueryDocumentSnapshot> listdocs = querySnapshot.docs;

    //* loop through docs to get data
    listdocs.forEach((element) {
      print(element.data());
      print("====================");
    });
  }
  //? ==================== call certain doc data  =============

  getDocData() async {
    DocumentReference doc =
        FirebaseFirestore.instance.collection("users").doc("123");
    //! get == Future == need await
    //* no need tp foreach to loop==
    await doc.get().then(
        (value) => {print(value.exists), print(value.id), print(value.data())});
  }

//? ============ call method => init =================
//* no need to btn =================================

  @override
  void initState() {
    getDataOfCollectionShortWay(); //! no need to press btn to get data ==============
    super.initState();
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
                  getDataOfCollection();
                },
                child: Text("get data of collection"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  getDocData();
                },
                child: Text("get data of doc"),
              ),
            ),
          ],
        ));
  }
}
