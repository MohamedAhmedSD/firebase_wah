// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:FaceBook_sign_in/FaceBook_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// //? ========== error ===========
// //*  'vepromiseToFuture'.
// //! solve it by remove both firebase auth and core webs then =?
// //! flutter clean => flutter pub get

// //* why after sign in I can't see it on users on FB but see it on my phone?

// https://developers.facebook.com/
// https://firebase.google.com/docs/auth/web/facebook-login


// class FaceBook extends StatefulWidget {
//   @override
//   _FaceBookState createState() => _FaceBookState();
// }
// //? read => https://firebase.flutter.dev/docs/auth/social

// class _FaceBookState extends State<FaceBook> {
//   //? ============ method =======================================
//  Future<UserCredential> signInWithFacebook() async {
//   // Trigger the sign-in flow
//   final LoginResult loginResult = await FacebookAuth.instance.login();

//   // Create a credential from the access token
//   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);

//   // Once signed in, return the UserCredential
//   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('FaceBook'),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             //* ============== Sign in with FaceBook =======================
//             Center(
//               child: ElevatedButton(
//                 onPressed: () async {
//                   UserCredential crud = await signInWithFacebook ();
//                   print(crud);
//                 },
//                 child: Text("FaceBook sign in"),
//               ),
//             ),
//           ],
//         ));
//   }
// }


// //?  =============== notes ===============
// /**
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// Future<UserCredential> signInWithFacebook() async {
//   // Trigger the sign-in flow
//   final LoginResult loginResult = await FacebookAuth.instance.login();

//   // Create a credential from the access token
//   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);

//   // Once signed in, return the UserCredential
//   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
// }
//  */