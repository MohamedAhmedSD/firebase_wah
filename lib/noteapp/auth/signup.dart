import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../component/alert.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //* vars, why I don't use TEC
  var myusername, mypassword, myemail;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  //* method
  signUp() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save(); //* save user state

      try {
        //* loading start
        showLoading(context);

        //* create new user
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: myemail, password: mypassword);

        //! don't forget return uC
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //! ====== why I use Nav ==============
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("Password is to weak"))
            ..show();
        } else if (e.code == 'email-already-in-use') {
          //! ====== why I use Nav ==============
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("The account already exists for that email"))
            ..show();
        }
      } catch (e) {
        print(e);
      }
    }
    // else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          //? ================ space && logo ============================
          SizedBox(height: 30),
          Center(child: Image.asset("assets/images/logo.png")),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
                key: formstate,
                //? TFF =================================================
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //? ======= username ======================
                      TextFormField(
                        onSaved: (val) {
                          myusername = val;
                        },
                        validator: (val) {
                          if (val!.length > 100) {
                            return "username can't to be larger than 100 letter";
                          }
                          if (val.length < 2) {
                            return "username can't to be less than 2 letter";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "username",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                      SizedBox(height: 20),
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
                            hintText: "email",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                      SizedBox(height: 20),
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
                      //? ======= username ======================
                      TextFormField(
                        onSaved: (val) {
                          myusername = val;
                        },
                        validator: (val) {
                          if (val!.length > 100) {
                            return "username can't to be larger than 100 letter";
                          }
                          if (val.length < 2) {
                            return "username can't to be less than 2 letter";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "username",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                      SizedBox(height: 20),
                      //? ======= email ======================
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
                            hintText: "email",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                      SizedBox(height: 20),
                      //? ======= password ======================
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
                      //? ==================== toggle ======================
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text("if you have Account "),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed("login");
                              },
                              child: Text(
                                "Click Here",
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                      ),
                      //? ================ sign up btn ====================
                      Container(
                          child: ElevatedButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.pink,
                          backgroundColor: Colors.pink,
                          iconColor: Colors.pink,
                        ),
                        // textColor: Colors.white,
                        onPressed: () async {
                          //* sign up => create new user
                          UserCredential response = await signUp();
                          print("===================");
                          // if (response != null) {
                          if (response != null) {
                            //* save user data inside collection
                            await FirebaseFirestore.instance
                                .collection("users")
                                .add(
                                    {"username": myusername, "email": myemail});
                            //* after save data go to => homepage
                            Navigator.of(context)
                                .pushReplacementNamed("homepage");
                          } else {
                            print("Sign Up Faild");
                          }
                          print("===================");
                        },
                        child: Text(
                          "Sign Up",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ))
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
