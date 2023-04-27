import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailAndPassword extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}
//? read => https://firebase.flutter.dev/docs/auth/password-auth

class _TestState extends State<EmailAndPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EmailAndPassword'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              //? ============== EmailAndPassword =======================
              //* ============== Sign up == Register =======================
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    //! they accept String
                    email: "btoox8python@gmail.com",
                    password: "Helo4@Helo.com",
                  );
                  // print(credential);
                  print("=====================================");

                  print(credential.user!.email);
                  print("=====================================");

                  print(credential.user!.emailVerified);
                  print("=====================================");

                  //! not able to see this data
                  // print(credential.credential!.providerId.toString());
                  // print("=====================================");
                  // print(credential.credential!.signInMethod.toString());
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text("sign up"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //* ============== Sign in == Login =======================
          Center(
            child: ElevatedButton(
              //? ============== EmailAndPassword =======================
              onPressed: () async {
                try {
                  final credential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: "btoox8python@gmail.com",
                    password: "Helo4@Helo.com",
                  );
                  print(credential);
                  print("=====================================");

                  print(credential.user!.email);
                  print("=====================================");

                  print(credential.user!.emailVerified);
                  print("=====================================");
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                }
              },
              child: Text("Sign in"),
            ),
          ),
        ],
      ),
    );
  }
}


//?  =============== notes ===============
/**
try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailAddress,
    password: password
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
 */

/**
 * try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailAddress,
    password: password
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
 */