//* may use dart, python, php .....

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api extends StatefulWidget {
  Api({Key? key}) : super(key: key);
  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
  //! we get server key from => FB consol => project settings =>
  //* cloud messaging => server key
  var serverToken = "";
  //! == make method
  sendNotify(String title, String body, String id) async {
    await http.post(
      Uri.parse("https:fcm.googleapis.com/fcm/send"),
      headers: <String, String>{
        "Content-type": "application/json",
        "Authorization": "Key=$serverToken",
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, String>{
            'body': body.toString(),
            'title': title.toString()
          },
          "priority": "high",
          'data': <String, dynamic>{
            //?========= here where we pass data parameters ===========
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': id.toString(),
            //?-----
            'name': 'btoo',
            'lastname': 'ahmed'
          },
          //! send to ==================================
          //* Returns the default FCM token for this device.

          'to': await FirebaseMessaging.instance.getToken()
        },
      ),
    );
  }

  //* make method to deal with notification in [FG]==
  getMessage() {
    FirebaseMessaging.onMessage.listen((m) {
      print("===================================");
      print(m.notification!.title);
      print(m.notification!.body);
      print(m.data['name']);
      print(m.data['lastname']);
    });
  }

  @override
  void initState() {
    getMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Two'),
      ),
      body: MaterialButton(
        onPressed: () async {
          await sendNotify("title", 'body', '1');
        },
        child: Text("send notify"),
      ),
    );
  }
}
