import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderAndOthers extends StatefulWidget {
  @override
  _OrderAndOthersState createState() => _OrderAndOthersState();
}

//* read => https://firebase.flutter.dev/docs/firestore/usage/

class _OrderAndOthersState extends State<OrderAndOthers> {
//? ==================== call certain collection data  =============
  getData() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");
    //* get
    //! get == Future == need await

    await userref.get().then((value) => {
          value.docs.forEach((element) {
            print(element.data());
            print("========================");
          })
        });
  }

//! ================== we need call doc inside collection =======
//? ========== Orderby , desending ================

  orderBy() async {
    //* collection
    CollectionReference? userref =
        FirebaseFirestore.instance.collection("users_");
    //* get
    //! get == Future == need await
    //* orderBy(Object field, {bool descending = false})

    await userref.orderBy("age", descending: false).get().then((value) => {
          value.docs.forEach((element) {
            print(element.data());
            // print(element.data()["age"]);
            // print(element.data()["lang"]);
            print("========================");
          })
        });
  }

  //? ========== from chatgpt ========================
  // void orderBy() async {
  //   //* collection
  //   CollectionReference? userref =
  //       FirebaseFirestore.instance.collection("users_");
  //   //* get
  //   //! get == Future == need await
  //   //* orderBy(Object field, {bool descending = false})

  //   QuerySnapshot querySnapshot = await userref.get();
  //   if (querySnapshot.docs.isNotEmpty) {
  //     for (var e in querySnapshot.docs
  //         .map((e) => (e) {
  //               print(e);
  //             })
  //         .toList()) {
  //       print(e.toString());
  //     }
  //   }
  // }
//? ========== Order and limit ================
//* ========== [A] Order and limit  =<  ================

  orderAndLimit() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");
    //* get
    //! get == Future == need await

    await userref
        .orderBy("age", descending: true)
        .limit(2)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                print(element.data());
                print("========================");
              })
            });
  }

  //* ========== [B] Order and limitToLast < ================
  orderAndLimitToLast() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");
    //* get
    //! get == Future == need await

    await userref
        .orderBy("age", descending: true)
        .limitToLast(2)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                print(element.data());
                print("========================");
              })
            });
  }

//? ========== Order and startAt ================
//* ========== [A] Order and startAt >=   ================

  orderAndStartAt() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");
    //* get
    //! get == Future == need await
    //! ============= use [] ================== 20 and more
    await userref
        .orderBy("age", descending: true)
        .startAt([20])
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                print(element.data());
                print("========================");
              })
            });
  }

//* ========== [B] Order and startAfter  > ================

  orderAndStartAfter() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");
    //* get
    //! get == Future == need await
    //! ============= use [] ================== 21
    await userref
        .orderBy("age", descending: false)
        .startAfter([20])
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                print(element.data());
                print("========================");
              })
            });
  }

//? ========== Order and endAt ================
//* ========== [A] Order and EndAt =<   ================

  orderAndEndAt() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");
    //* get
    //! get == Future == need await
    //! ============= use [] ================== 20 and more
    await userref
        .orderBy("age", descending: false)
        .endAt([20])
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                print(element.data());
                print("========================");
              })
            });
  }

//* ========== [B] Order and EndBefore  < ================

  orderAndEndBefore() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");
    //* get
    //! get == Future == need await
    //! ============= use [] ================== 21
    await userref
        .orderBy("age", descending: true)
        .endBefore([20])
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                print(element.data());
                print("========================");
              })
            });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

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
                  orderBy();
                },
                child: Text("Orderby , desending"),
              ),
            ),

            //? ========== order and limit ================

            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  orderAndLimit();
                },
                child: Text("orderAndLimit"),
              ),
            ),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  orderAndLimitToLast();
                },
                child: Text("orderAndLimitToLast"),
              ),
            ),
            //? ========== Order and startAt ================
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  orderAndStartAt();
                },
                child: Text("orderAndStartAt"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  orderAndStartAfter();
                },
                child: Text("orderAndStartAfter"),
              ),
            ),
//? ========== Order and endAt ================
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  orderAndEndAt();
                },
                child: Text("orderAndEndAt"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  orderAndEndBefore();
                },
                child: Text("orderAndEndBefore"),
              ),
            ),
          ],
        ));
  }
}

/**
 * https://console.firebase.google.com/v1/r/project/ecommerce-tarek/firestore/indexes?create_composite=Ck5wcm9qZWN0cy9lY29tbWVyY2UtdGFyZWsvZGF0YWJhc2VzLyhkZWZhdWx0KS9jb2xsZWN0aW9uR3JvdXBzL3VzZXJzXy9pbmRleGVzL18QARoICgRsYW5nGAEaBwoDYWdlEAEaDAoIX19uYW1lX18QAQ
 */

/**
 * W/Firestore( 3500): (24.5.0) [Firestore]: Listen for Query(target=Query(users_ where langarray_contains_any[ar,gr] and age>22 order by age, __name__);limitType=LIMIT_TO_FIRST) failed: Status{code=FAILED_PRECONDITION, description=The query requires an index. You can create it here: https://console.firebase.google.com/v1/r/project/ecommerce-tarek/firestore/indexes?create_composite=Ck5wcm9qZWN0cy9lY29tbWVyY2UtdGFyZWsvZGF0YWJhc2VzLyhkZWZhdWx0KS9jb2xsZWN0aW9uR3JvdXBzL3VzZXJzXy9pbmRleGVzL18QARoICgRsYW5nGAEaBwoDYWdlEAEaDAoIX19uYW1lX18QAQ, cause=null}
 */