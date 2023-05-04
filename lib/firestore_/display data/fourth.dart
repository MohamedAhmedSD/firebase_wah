import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FourthWay extends StatefulWidget {
  const FourthWay({super.key});

  @override
  State<FourthWay> createState() => _FourthWayState();
}

//! === when use streambuilder no need to? ==========
//* no list, no init need
//? it to deal with real time data

//* collection access => then call on our FB widget
CollectionReference noteref = FirebaseFirestore.instance.collection("notes");

class _FourthWayState extends State<FourthWay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data by Future.Builder'),
      ),
      body: StreamBuilder(
          //* snapshot()  not snapshpt
          //? use snapshot() rather than get()
          stream: noteref.snapshots(), //! Stream<QuerySnapshot<>

          //* builder => context + snapshot
          //? snapshot == which save and store data that back to me ======
          builder: (context, snapshot) {
            //* always check is there data or not first =======
            if (snapshot.hasData) {
              return
                  // Text("Data");

                  //? ======= AsyncSnapshot<QuerySnapshot> == list ======
                  //* so we use ListView to display it ==================
                  ListView.builder(
                      //* [1]
                      // itemCount: snapshot
                      //     .data!.docs.length, //? to reach into list lenght
                      //* [2]
                      itemCount: snapshot.data?.docs.length ??
                          0, //? to reach into list lenght

                      //* [3]
                      itemBuilder: (context, i) {
                        //* docs == snapshot.data!.docs[i]
                        //* fields == .data()
                        //? ==== see all data ========================
                        // return Text("${snapshot.data!.docs[i].data()}");
                        //? ==== only name ========================
                        //! error Object cann't assign to Map
                        // return Text("${snapshot.data!.docs[i].data()['name']}");
                        //? =================================================
                        //* === how we solve it => as ..... ==================
                        // Map<String, dynamic> data = snapshot.data!.docs[i]
                        //     .data() as Map<String, dynamic>;
                        //? ============= apply it ===========================
                        if (snapshot.hasData && snapshot.data != null) {
                          Map<String, dynamic> data = snapshot.data!.docs[i]
                              .data() as Map<String, dynamic>;
                          //* now we can use data == Map<String, dynamic> to
                          //* reach our fields values ===================

                          return Text("${data['title']}");
                        } else {
                          return Text("Loading");
                        }
                      });
            }
            if (snapshot.hasError) {
              return Text("Error");
            }
            //! what happen on waitting data, better use Loading
            //* as return for all code rather than it
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Text("Loading");
            // }

            return Text("Loading");
          }),
    );
  }
}
