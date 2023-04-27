// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// // import 'package:GitHub_sign_in/GitHub_sign_in.dart';
// import 'package:github_sign_in/github_sign_in.dart';

//! depricated and not work with null safty
// // import 'package:github_signin_promax/github_signin_promax.dart';
// //? ========== error ===========
// // https://github.com/settings/applications/new
// // https://ecommerce-tarek.firebaseapp.com/__/auth/handler
// // https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/creating-an-oauth-app

// // a1183d35cefda02eafdc93fae854b9ebc926bc05
// // 47f73c397eb3c75e361c

// class GitHub extends StatefulWidget {
//   @override
//   _GitHubState createState() => _GitHubState();
// }
// //? read => https://firebase.flutter.dev/docs/auth/social

// class _GitHubState extends State<GitHub> {
//   //? ============ method =======================================

//   Future<UserCredential> signInWithGitHub() async {
//     // Create a GitHubSignIn instance
//     final GitHubSignIn gitHubSignIn = GitHubSignIn(
        // clientId: "47f73c397eb3c75e361c",
        // clientSecret: "a1183d35cefda02eafdc93fae854b9ebc926bc05",
        // redirectUrl: 'https://ecommerce-tarek.firebaseapp.com/__/auth/handler');

//     // Trigger the sign-in flow
//     final result = await gitHubSignIn.signIn(context);

//     // Create a credential from the access token
//     final githubAuthCredential = GithubAuthProvider.credential(result.token);

//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance
//         .signInWithCredential(githubAuthCredential);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('GitHub'),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             //* ============== Sign in with GitHub =======================
//             Center(
//               child: ElevatedButton(
//                 onPressed: () async {
//                   UserCredential crud = await signInWithGitHub();
//                   print(crud);
//                 },
//                 child: Text("github sign in"),
//               ),
//             ),
//           ],
//         ));
//   }
// }

// //?  =============== notes ===============
// /**
// import 'package:github_sign_in/github_sign_in.dart';

// Future<UserCredential> signInWithGitHub() async {
//   // Create a GitHubSignIn instance
//       final GitHubSignIn gitHubSignIn = GitHubSignIn(
//           clientId: clientId,
//           clientSecret: clientSecret,
//           redirectUrl: 'https://my-project.firebaseapp.com/__/auth/handler');

//   // Trigger the sign-in flow
//   final result = await gitHubSignIn.signIn(context);

//   // Create a credential from the access token
//   final githubAuthCredential = GithubAuthProvider.credential(result.token);

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
// }
//  */
