import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../crud/editnotes.dart';
import '../crud/viewnotes.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //* reach to notes collection
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");
  //
  getUser() {
    var user = FirebaseAuth.instance.currentUser;
    print(user!.email);
  }

  //! use FBCM === [ test purpuse ]============================================
  //* we need it to get device token when init this page
  var fbm = FirebaseMessaging.instance;

  //? ==== we need know what used when app close and what used if it on background mode
  //* ====================[getInitialMessage]==============================
  // If the application has been opened from a terminated state
  // via a [RemoteMessage] (containing a [Notification]),
  // it will be returned, otherwise it will be null.

  initalMessage() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      Navigator.of(context).pushNamed("addnotes");
    }
  }

  //* ============== we need it if we use IOS ========================
  requestPermssion() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    //
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
  //!=========================================================================

  @override
  void initState() {
    requestPermssion();
    initalMessage();
    //* get device token =====================================================
    fbm.getToken().then((token) {
      print("=================== Token ==================");
      print(token);
      print("====================================");
    });

    //! ======= should be under init => or get error with unser non abstract class
    //* how we useful from reach message on foreground ==> by make an event our method
    //? notification have title && body ===

    //* ====================[onMessage]==============================
    //? Stream<RemoteMessage> get onMessage
    //! Returns a Stream that is called when an incoming FCM payload is
    //* received whilst the Flutter instance is in the foreground.

    FirebaseMessaging.onMessage.listen((event) {
      print(
          "===================== data Notification ==============================");
      // print("${event.notification!.title}");
      // print("${event.notification!.body}");
      //! event have alot of probrties ===========
      // print("${event.data}");
      // print("${event.sentTime}");
      // print("${event.senderId}");
      // print("${event.messageId}");

      //  AwesomeDialog(context: context , title: "title" , body: Text("${event.notification.body}"))..show() ;

      Navigator.of(context).pushNamed("addnotes");
    });

    //* ====================[onMessageOpenedApp]==============================
    //? Returns a [Stream] that is called when a user presses a notification message displayed via FCM.
    //* A Stream event will be sent if the app has opened from a background state (not terminated).
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   Navigator.of(context).pushNamed("addnotes");
    // });

    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        actions: [
          //? ============== signout from auth ===========================
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                //* then nav into login
                Navigator.of(context).pushReplacementNamed("login");
              })
        ],
      ),
      //? ========== nav into add page ============================
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed("addnotes");
          }),
      body: Container(
        //? ====== we use futurebuilder , try streamBuilder ===========
        child: FutureBuilder(
            //! it get data from collection for certain id by using where====
            //* both must equal userid that saved on notes with that we get from
            //* our current user
            future: notesref
                .where("userid",
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .get(), //* get()  == back future ============================
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //* print(" has data");

                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, i) {
                      //? === Dismissible =======
                      //* ==== Delete ====================================
                      //* delete when drag right or left
                      return Dismissible(
                        onDismissed: (diretion) async {
                          //* =============== [A] delete from FBFB ===========
                          //? ====== [1] delete doc ======================
                          await notesref
                              .doc(snapshot.data!.docs[i].id)
                              .delete();
                          //* ====== [2] delete image from FBFS ===========
                          await FirebaseStorage.instance
                              //! Reference refFromURL(String url)
                              //* url of img
                              .refFromURL(snapshot.data!.docs[i]['imageurl'])
                              .delete()
                              .then((value) {
                            print("=================================");
                            print("Delete");
                          });
                        },
                        //! ====== use key => must be uniqe == no way to repeat
                        //*======== [B] delete from UI ===================
                        key: UniqueKey(),
                        child: ListNotes(
                          notes: snapshot.data!.docs[i],
                          docid: snapshot.data!.docs[i].id,
                        ),
                      );
                    });

                //! ======= old =========
                // return ListView.builder(
                //     itemCount: snapshot.data!.docs.length,
                //     itemBuilder: (context, i) {
                //       // return Text("${snapshot.data!.docs[i].data()}");
                //       //! ==== the method [] cann't be unconditionally ...
                //       if (snapshot.data != null) {
                //         return Text(
                //             "${snapshot.data!.docs[i].data()["title"]}");
                //       }
                //       //! to avoid error when waiting data
                //       return Center(child: CircularProgressIndicator());
                //     });
              }
              //! to avoid error when waiting data
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}

//* widget ====================================================================
class ListNotes extends StatelessWidget {
  //! we get its values later as =>
  final notes; //* == snapshot.data!.docs[i],
  final docid; //* snapshot.data!.docs[i].id,
  ListNotes({this.notes, this.docid});
  @override
  Widget build(BuildContext context) {
    //* when nav inro view => pass notes value
    return InkWell(
      onTap: () {
        //* ========================= nav to view ============================
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ViewNote(notes: notes);
        }));
      },
      child: Card(
        //? image and title, content, icon ======================
        child: Row(
          children: [
            //? ===== img =======
            Expanded(
              flex: 1,
              child: Image.network(
                //? === notes == snapshot.data!.docs[i],
                "${notes['imageurl']}",
                fit: BoxFit.fill,
                height: 80,
              ),
            ),
            Expanded(
              flex: 3,
              //? ===== title then under it note =======
              child: ListTile(
                //? === notes == snapshot.data!.docs[i],
                title: Text("${notes['title']}"),
                subtitle: Text(
                  "${notes['note']}",
                  style: TextStyle(fontSize: 14),
                ),
                //? ====== icon => edit => pass both docid && notes list ===
                trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return EditNotes(docid: docid, list: notes);
                    }));
                  },
                  icon: Icon(Icons.edit),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
