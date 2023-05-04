import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int opt = 0; //* number of accounts regesterd

  @override
  void initState() {
    super.initState();
    registerAccount();
  }

  void registerAccount() {
    //! no account add once, regester
    //! if there sign in
    if (opt == 0) {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: 'btoox8python@gmail.com',
        password: 'password',
      );
    } else {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'btoox8python@gmail.com',
        password: 'password',
      );
    }
  }

  //! why we not use here =>   late UserCredential? userCredential;
  void verifyEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    //Check if user is not verified
    if (!(user!.emailVerified)) {
      user.sendEmailVerification();
    }
  }

  void sendResetPassword() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.sendPasswordResetEmail(
      email: user!.email.toString(), //! email => String
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //? ===== [Verify Email] =====
            GestureDetector(
              onTap: () {
                verifyEmail();
              },
              child: Container(
                height: 50,
                width: 200,
                color: Colors.blue,
                margin: EdgeInsets.only(bottom: 16),
                child: Center(
                  child: Text(
                    "Verify Email",
                  ),
                ),
              ),
            ),
            //? ===== [Reset Password] =====
            GestureDetector(
              onTap: () {
                sendResetPassword();
              },
              child: Container(
                height: 50,
                width: 200,
                color: Colors.blue,
                margin: EdgeInsets.only(bottom: 16),
                child: Center(
                  child: Text(
                    "Reset Password",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
