import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}
//? read => https://firebase.flutter.dev/docs/auth/manage-users

class _VerifyState extends State<Verify> {
  //! solve error when not make it late here we cann't access it for verify ====

  //? A UserCredential is returned from authentication requests such as
  //*[createUserWithEmailAndPassword].

  late UserCredential? userCredential;

  void verifyEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    //* ========  Check if user is not verified  =============
    //! Returns whether the users email address has been verified.
    //* !false => true
    if (!(user!.emailVerified)) {
      user.sendEmailVerification(); //! Sends a verification email to a user.
      print(user.emailVerified);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Verify'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* ============== Sign in then Verify =======================
            Center(
              child: ElevatedButton(
                //? ============== EmailAndPassword =======================
                onPressed: () async {
                  verifyEmail();
                },
                child: Text("Sign in"),
              ),
            ),
          ],
        ));
  }
}

//?  =============== [ default code ] ===============
/**
Send a user a verification email#
You can send an address verification email to a user with the 
sendEmailVerification() method. For example:

await user?.sendEmailVerification();
You can customize the email template that is used in Authentication section
 of the Firebase console, on the Email Templates page. See Email Templates 
 in Firebase Help Center.

It is also possible to pass state via a continue URL to redirect back to 
the app when sending a verification email.

Additionally you can localize the verification email by updating
 the language code on the Auth instance before sending the email. 
 For example:

await FirebaseAuth.instance.setLanguageCode("fr");
await user?.sendEmailVerification();
 */
