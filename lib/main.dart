import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wah_firebase/firebase_options.dart';

import 'noteapp/auth/login.dart';
import 'noteapp/auth/signup.dart';
import 'noteapp/crud/addnotes.dart';
import 'noteapp/home/homepage.dart';
import 'noteapp/testtwo.dart';

//? ======== notes ===================
//! we can get SHA also by go => cd android  ,then write =>
//* ./gradlew signingReport

//* [1] Manuall installation:-
//? https://firebase.flutter.dev/docs/manual-installation/android/
//* connect with firebase by way you want

//? MultiDex only if minSdk less than 21 >>>>>>>>>>>>>>>>>>>>>>>>>
//* Enabling Multidex, after modify sdks => multiDexEnabled true
//! and its implementaion on depencies

//* read how connect with web == index.html => start point

//* why we use firebase core ?
//? it connect our app to firebase services

//! =========== [ why they are global ?? bad or not ] ==================
bool? islogin;

//* RemoteMessage => A class representing a message sent from Firebase Cloud Messaging.
//* ====================[onBackgroundMessage]==============================
//! [1] first way ==========================================================
//? void onBackgroundMessage(Future<void> Function(RemoteMessage) handler)
//! Set a message handler function which is called when the app is in the background or terminated.
//? async =>  async =>  async =>  async =>  async =>  async =>
// FirebaseMessaging.onBackgroundMessage((message) async {
//   print("===== Background Notification ==============================");
//   print("${message.notification!.body}");
// });

//! [2] second way
Future backgroudMessage(RemoteMessage message) async {
  print("=================== BackGroud Message ========================");

  //! Additional Notification data sent with the message.
  //* body => The notification body content.
  print("${message.notification!.body}");
}

//? ======== connect to FB ===================
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //* you can change options according to your device
      // options: DefaultFirebaseOptions.currentPlatform,
      options: DefaultFirebaseOptions.android);

  //? ========= call onBackgroundMessage =============
  FirebaseMessaging.onBackgroundMessage(backgroudMessage);

  //? ======== get the CURRENTUSER by AUTH =======
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    islogin = false;
  } else {
    islogin = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //* ===== allow user enter to homepage if he already regester ====
      home: islogin == false ? Login() : HomePage(),
      //* test AddUser function with dump data
      // home: AddUser("mohamed", "sheikh", 22),
      // home: MyStorage(),

      // home: Test(),
      theme: ThemeData(
        // fontFamily: "NotoSerif",
        primaryColor: Colors.blue,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 20, color: Colors.white),
          headlineSmall: TextStyle(fontSize: 30, color: Colors.blue),
          bodyMedium: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      //? we make our routes with out /
      routes: {
        "login": (context) => Login(),
        "signup": (context) => SignUp(),
        "homepage": (context) => HomePage(),
        "addnotes": (context) => AddNotes(),
        "testtwo": (context) => TestTwo()
      },
    );
  }
}
