import 'package:flutter/material.dart';
import 'package:github_signin_promax/github_signin_promax.dart'; //! new lib

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String
      title; //? === when call this page I should give it  a value to title

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String response = '';

  void _incrementCounter() {
    setState(() {
      response = '';
    });

    //? we assign values to => GithubSignInParams
    var params = GithubSignInParams(
      clientId: "47f73c397eb3c75e361c",
      clientSecret: "a1183d35cefda02eafdc93fae854b9ebc926bc05",
      redirectUrl: 'https://ecommerce-tarek.firebaseapp.com/__/auth/handler',
      scopes: 'read:user,user:email',
    );
    //! how we get these values??=======================================

    //!=================================================================

    //? use that values to access => GithubSigninScreen
    Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
      return GithubSigninScreen(
        params: params,
      );
    })).then((value) {
      setState(() {
        response +=
            '✅ Status: \t ${(value as GithubSignInResponse).status}\n\n';
        response += '✅ Code: \t ${(value).accessToken}\n\n';
        response += '✅ Error: \t ${(value).error}\n\n';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              response,
              style: const TextStyle(color: Colors.green, fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Login',
        child: const Icon(Icons.login),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
