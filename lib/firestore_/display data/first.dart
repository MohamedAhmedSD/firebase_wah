import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirstWay extends StatefulWidget {
  const FirstWay({super.key});

  @override
  State<FirstWay> createState() => _FirstWayState();
}

class _FirstWayState extends State<FirstWay> {
  //* empty list to add data we get it, on it
  List users = [];
  List usersdoc = [];

  //* collection ref
  CollectionReference userref = FirebaseFirestore.instance.collection("users_");

  //* doc
  DocumentReference docref = FirebaseFirestore.instance.collection("users_").doc(
      "GoTbbtFbHK3CO4hFG5fQ"); //! some times we need change doc id test another

  //? method to getData =================================================
  getData() async {
    //* save data that we get on var == responsebody
    var responsebody = await userref.get();

    //* we need docs, docs == List<QueryDocumentSnapshot<Object?>>
    // responsebody.docs;
    //* loop through them, then add its element on our empty list
    responsebody.docs.forEach((element) {
      //? ========== we put them inside setState, to see them on UI=============
      setState(() {
        // users.add(element);  //! not this
        users.add(element.data()); //* need .data()  == data == all fields
      });
    });
    //* check data => does our empty list, add data
    print(users);
  }

//? method to getData =================================================
  getDocData() async {
    //* save data that we get on var == responsebody == DocumentSnapshot
    var responsebody = await docref.get();
    //* display them on UI
    setState(() {
      //* add our DocumentSnapshot to list => users
      usersdoc.add(responsebody.data()); //! don't forger .data() ============
    });
    print("-=--==========================");
    print(usersdoc);
  }

  //! HINT : bring data should be automatically when start app => init
  @override
  void initState() {
    getData();
    getDocData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('data by ListView.Builder'),
        ),
        //! ===== we use our list == users alot =============
        body: Column(
          children: [
            //? =============== collecrion ===========================
            // Container(
            //   height: 300,
            //   child: ListView.builder(
            //       physics: NeverScrollableScrollPhysics(),
            //       shrinkWrap: true,
            //       itemCount: users.length,
            //       itemBuilder: (context, i) {
            //         return
            //             //? ======== only age =======================
            //             // Text("${users[i]["age"]}"); //* users[doc][field]
            //             //? ======== list tile for age and name =======
            //             ListTile(
            //           title: Text("${users[i]["name"]}"), //* users[doc][field]
            //           trailing:
            //               Text("${users[i]["age"]}"), //* users[doc][field]
            //         );
            //       }),
            // ),
            SizedBox(
              height: 20,
            ),
            //! === handle error of invalid value due to async ===========
            usersdoc.isEmpty
                ? Text(" loading")
                :
                //? =============== doc ===========================
                ListTile(
                    title:
                        Text("${usersdoc[0]["name"]}"), //* usersdoc[0][field]
                    trailing:
                        //! ======== age != Age ==== becarful ==================
                        Text("${usersdoc[0]["Age"]}"), //* usersdoc[0][field]
                  ),
          ],
        ));
  }
}
