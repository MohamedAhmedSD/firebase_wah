import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../component/alert.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //* vars, why not use TEC
  var mypassword, myemail;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  //* method
  signIn() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save(); //* save user state
      try {
        //* loading
        showLoading(context);
        //* sign in
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: myemail, password: mypassword);
        //! don't forget return
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          //! == close loading =========
          Navigator.of(context).pop();
          //! then open ================
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("No user found for that email"))
            ..show();
        } else if (e.code == 'wrong-password') {
          //! == close loading =========
          Navigator.of(context).pop();
          //! then open ================
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("Wrong password provided for that user"))
            ..show();
        }
      }
    } else {
      print("Not Vaild");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //? ================ logo ======================================
          Center(child: Image.asset("assets/images/logo.png")),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
                key: formstate,
                child: Column(
                  children: [
                    //? ================ email ======================================
                    TextFormField(
                      onSaved: (val) {
                        myemail = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "Email can't to be larger than 100 letter";
                        }
                        if (val.length < 2) {
                          return "Email can't to be less than 2 letter";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    SizedBox(height: 20),
                    //? ================ password ======================================
                    TextFormField(
                      onSaved: (val) {
                        mypassword = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "Password can't to be larger than 100 letter";
                        }
                        if (val.length < 4) {
                          return "Password can't to be less than 4 letter";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "password",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    //? ================ toggle ======================================
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text("if you havan't accout "),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed("signup");
                            },
                            child: Text(
                              "Click Here",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),
                    //? ================ sign in btn ======================================
                    Container(
                        child: ElevatedButton(
                      // textColor: Colors.white,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.pink,
                        backgroundColor: Colors.pink,
                        iconColor: Colors.pink,
                      ),
                      onPressed: () async {
                        //* sign in ==================
                        var user = await signIn();
                        //! no need save data t ofirestore
                        //* we bring data of user by sign in
                        //* if there data go to => homepage
                        if (user != null) {
                          Navigator.of(context)
                              .pushReplacementNamed("homepage");
                        }
                      },
                      child: Text(
                        "Sign in",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ))
                  ],
                )),
          )
        ],
      ),
    );
  }
}

/*

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please Wait"),
          content: Container(
              height: 50,
              child: Center(
                child: CircularProgressIndicator(),
              )),
        );
      });
}


*/
