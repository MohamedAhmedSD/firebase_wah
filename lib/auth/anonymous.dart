import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Anonymous extends StatefulWidget {
  @override
  _AnonymousState createState() => _AnonymousState();
}
//! jiffy packages have pt\roblem with firebase
//? read => https://firebase.flutter.dev/docs/auth/anonymous-auth

class _AnonymousState extends State<Anonymous> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Anonymous'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: ElevatedButton(
              //? ============== Anonymous =======================
              onPressed: () async {
                try {
                  final userCredential =
                      await FirebaseAuth.instance.signInAnonymously();
                  print(userCredential);
                  print("=====================================");
                  print(userCredential.user!.uid); //! VIP
                  print("=====================================");
                  print("Signed in with temporary account.");
                  print("=====================================");
                } on FirebaseAuthException catch (e) {
                  switch (e.code) {
                    case "operation-not-allowed":
                      print(
                          "Anonymous auth hasn't been enabled for this project.");
                      break;
                    default:
                      print("Unknown error.");
                  }
                }
              },
              child: Text("Sign in Anonymous "),
            ))
          ],
        ));
  }
}


//?  =============== notes ===============
/**
 * try {
  final userCredential =
      await FirebaseAuth.instance.signInAnonymously();
  print("Signed in with temporary account.");
} on FirebaseAuthException catch (e) {
  switch (e.code) {
    case "operation-not-allowed":
      print("Anonymous auth hasn't been enabled for this project.");
      break;
    default:
      print("Unknown error.");
  }
}
 */