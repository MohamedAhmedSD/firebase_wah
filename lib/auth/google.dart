import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

//? ========== error ===========
//*  'vepromiseToFuture'.
//! solve it by remove both firebase auth and core webs then =?
//! flutter clean => flutter pub get
//?=============================

//* why after sign in I can't see it on users on FB but see it on my phone? ===

class Google extends StatefulWidget {
  @override
  _GoogleState createState() => _GoogleState();
}
//? read => https://firebase.flutter.dev/docs/auth/social

class _GoogleState extends State<Google> {
  //? ============ method =======================================
  Future<UserCredential> signInWithGoogle() async {
    //? Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //* get user information
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    //! Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    //* output
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Google'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* ============== Sign in with Google =======================
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  UserCredential cred = await signInWithGoogle();
                  print(cred);
                },
                child: Text("google sign in"),
              ),
            ),
          ],
        ));
  }
}


//?  =============== [ default code ] ===============
/**
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
 */