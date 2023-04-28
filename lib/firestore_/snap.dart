import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Snap extends StatefulWidget {
  @override
  _SnapState createState() => _SnapState();
}

//* read => https://firebase.flutter.dev/docs/firestore/usage/

class _SnapState extends State<Snap> {
//? ==================== call certain collection data  =============
  getData() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");
    //* get
    //! get == Future == need await

    await userref.get().then((value) => {
          value.docs.forEach((element) {
            // print("${element.data()["age"]}");
            print("${element.data()}");
            // print("========================");
            // element.data() as int; ["age"];
          })
        });
  }

//? ========== update data on realtime ================
//* ========== no need to hot restart ================

  getSnapShotData() async {
    //* collection
    //* QuerySnapshot<Map<String, dynamic>> == event

    FirebaseFirestore.instance.collection("users_").snapshots().listen((event) {
      event.docs.forEach((element) {
        // print(element.data());
        print("==========================");
        print(element.data()["age"]); //! == we can access certain field ====
        print("==========================");
      });
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
                  getData();
                },
                child: Text("get data of users_"),
              ),
            ),
            //? ========== order ================
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  getSnapShotData();
                },
                child: Text("getSnapshotdata"),
              ),
            ),
          ],
        ));
  }
}
