import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SecondWay extends StatefulWidget {
  const SecondWay({super.key});

  @override
  State<SecondWay> createState() => _SecondWayState();
}

//! === when use FutureBuilder no need to? ==========
//* no list, no init need ==========================

//* collection access => then call on our FB widget
CollectionReference userref = FirebaseFirestore.instance.collection("users_");

class _SecondWayState extends State<SecondWay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data by Future.Builder'),
      ),
      body: FutureBuilder(
          future: userref.get(), //!  userref.get() == future======
          //* builder => context + snapshot
          //? snapshot == which save and store data that back to me ======
          //* get == back => QuerySnapshot
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

                          return Text("${data['age']}");
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

//!  ======================== from chatgpt =====================================
      //     FutureBuilder(
      //   future: userref.get(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return ListView.builder(
      //         itemCount: snapshot.data!.docs.length,
      //         itemBuilder: (context, i) {
      //           Map<String, dynamic> data =
      //               snapshot.data!.docs[i].data() as Map<String, dynamic>;
      //           return Text(data['name']);
      //         },
      //       );
      //     } else {
      //       return CircularProgressIndicator();
      //     }
      //   },
      // )
    );
  }
}

/**
 * Sure! This error occurs when you try to assign a value of type `Object?` 
 * to a variable of type `Map<String, dynamic>`. 

Here's an example of how this error might occur:

```
Map<String, dynamic> data;

void fetchData() async {
  final response = await http.get(Uri.parse('https://example.com/data'));
  final decodedResponse = json.decode(response.body);
  data = decodedResponse;
}
```

In this code, we have defined a `data` variable of type `Map<String, dynamic>` 
and a `fetchData` function that fetches some data from an API and assigns 
it to the `data` variable. However, 
the `decodedResponse` value obtained from decoding the response body 
is of type `Object?`. 

To fix this error, we can either change the type of the `data` 
variable to `dynamic` (which can hold any type of value), 
or cast the `decodedResponse` value to the required type:

```
Map<String, dynamic> data;

void fetchData() async {
  final response = await http.get(Uri.parse('https://example.com/data'));
  final decodedResponse = json.decode(response.body) as Map<String, dynamic>;
  data = decodedResponse;
}
```

In this updated code, we have cast the `decodedResponse` value as 
`Map<String, dynamic>` so that it can be assigned to the `data` variable of that type.

I hope this helps!
 */
