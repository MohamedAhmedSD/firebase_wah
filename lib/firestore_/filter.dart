import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
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

//? ========== filter 1 => String ================
//* ============= where it come before get ================
//* as getDate + where stmt =================================
/**
 * Query<Object?> where(
  Object field, {
  Object? isEqualTo,
  Object? isNotEqualTo,
  Object? isLessThan,
  Object? isLessThanOrEqualTo,
  Object? isGreaterThan,
  Object? isGreaterThanOrEqualTo,
  Object? arrayContains,
  Iterable<Object?>? arrayContainsAny,
  Iterable<Object?>? whereIn,
  Iterable<Object?>? whereNotIn,
  bool? isNull,
})
 */
  filterDataString() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");
    //* get
    //! get == Future == need await

    await userref.where("company", isEqualTo: "sheikh").get().then((value) => {
          value.docs.forEach((element) {
            print(element.data());
            print("========================");
          })
        });
  }

//? ========== filter 2 => numbers ================

  filterDataNumber() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");
    //* get
    //! get == Future == need await

    await userref.where("age", isLessThanOrEqualTo: 35).get().then((value) => {
          value.docs.forEach((element) {
            print(element.data());
            print("========================");
          })
        });
  }

//? ========== filter 3 => MultiValues ================
//* =========== whereIn [] / whereNotIn [] ============

  filterMultiValues() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");
    //* get
    //! get == Future == need await

    await userref
        .where("age", whereIn: [22, 20, 40, 33])
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                print(element.data());
                print("========================");
              })
            });
  }

  //? ========== filter 4 => array ================
//* =========== arrayContains => String /arrayContainAny => array ============
  filterArrayContains() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");
    //* get
    //! get == Future == need await

    await userref.where("lang", arrayContains: "fr").get().then((value) => {
          value.docs.forEach((element) {
            print(element.data());
            print("========================");
          })
        });
  }

  //*=======================
  filterArrayContainAny() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");
    //* get
    //! get == Future == need await

    await userref
        .where("lang", arrayContainsAny: ["ar", "gr"])
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                print(element.data());
                print("========================");
              })
            });
  }

  //? ========== filter 5 => multi fields ================
  filterMultiFields() async {
    //* collection
    CollectionReference userref =
        FirebaseFirestore.instance.collection("users_");
    //* get
    //! get == Future == need await

    //* ==== where().where().get().... =======================
    //* it give error =>>>>>>>>>>>>>> need idexed ============
    //! manually from cloude FS or from http link on error message
    //? copy http link to end without , =======================
    //* ========= index take time => hot restart ==========================

    await userref
        .where("lang", arrayContainsAny: ["ar", "gr"])
        .where("age", isGreaterThan: 15)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                print(element.data());
                print("========================");
              })
            });
  }

  @override
  void initState() {
    super.initState();
    getData();
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
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  filterDataNumber();
                },
                child: Text("filter data of users_ age < 35"),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  filterDataString();
                },
                child: Text("filter data of users_ company == sheikh"),
              ),
            ),
            //? ============= multibleValues ========
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  filterMultiValues();
                },
                child: Text("filter data of users_ age == 22,20,40,33"),
              ),
            ),
            //? ============= array contains ========
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  filterArrayContains();
                },
                child: Text("filter data of users_ lang == fr"),
              ),
            ),
            //? ============= array contain any ========
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  filterArrayContainAny();
                },
                child: Text("filter data of users_ lang == ar,gr & age > 22"),
              ),
            ),
            //? ============= multi fields ========
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //! not need to async & await
                  filterMultiFields();
                },
                child: Text("filter data of users_ lang == ar or gr, age > 15"),
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