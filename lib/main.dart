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

//* read how uconnect with web == index.html

//* why we use firebase core ?
//? it connect our app to firebase services

//? =========================
bool? islogin;

Future backgroudMessage(RemoteMessage message) async {
  print("=================== BackGroud Message ========================");
  print("${message.notification!.body}");
}

//? ======== connect to FB ===================
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //* you can change options according to your device
      // options: DefaultFirebaseOptions.currentPlatform,
      options: DefaultFirebaseOptions.android);

  //? =========
  FirebaseMessaging.onBackgroundMessage(backgroudMessage);

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: islogin == false ? Login() : HomePage(),
      home: Login(),
      // home: Test(),
      theme: ThemeData(
          // fontFamily: "NotoSerif",
          primaryColor: Colors.blue,
          textTheme: TextTheme(
            titleLarge: TextStyle(fontSize: 20, color: Colors.white),
            headlineSmall: TextStyle(fontSize: 30, color: Colors.blue),
            bodyMedium: TextStyle(fontSize: 20, color: Colors.black),
          )),
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
