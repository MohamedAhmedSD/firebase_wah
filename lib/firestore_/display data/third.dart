import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ThirdWay extends StatefulWidget {
  const ThirdWay({super.key});

  @override
  State<ThirdWay> createState() => _ThirdWayState();
}

//! === when use FutureBuilder no need to? ==========
//* no list, no init need

//* doc access => then call on our FB widget
DocumentReference docref =
    FirebaseFirestore.instance.collection("users_").doc("6ZfHkphjkdiSJE99NNCl");

class _ThirdWayState extends State<ThirdWay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data by Future.Builder'),
      ),
      body: FutureBuilder(
          future: docref.get(), //!  docref.get() == future======
          //* builder => context + snapshot
          //? snapshot == which save and store data that back to me ======
          builder: (context, snapshot) {
            //* always check is there data or not first =======
            if (snapshot.hasData) {
              //?========== delete docs ========
              if (snapshot.hasData && snapshot.data != null) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                //* now we can use data == Map<String, dynamic> to
                //* reach our fields values ===================

                return Text("${data['age']}");
              } else {
                return Text("Loading");
              }
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
