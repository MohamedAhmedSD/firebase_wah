import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wah_firebase/firebase_options.dart';

import 'auth/github2.dart';

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

//? ======== connect to FB ===================
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //* you can change options according to your device
      // options: DefaultFirebaseOptions.currentPlatform,
      options: DefaultFirebaseOptions.android);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FireBase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: '',
      ),
    );
  }
}
