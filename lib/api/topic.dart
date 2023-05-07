//* to use tolin for all devices
//? we use our get token method then save token on FBFS to use it on FCM
//* we need update token with every new user

//! how we see [FG] notification on open app
//* by using local notification with FCM

//?======================================================================
//* may use dart, python, php .....

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Topics extends StatefulWidget {
  Topics({Key? key}) : super(key: key);
  @override
  _TopicsState createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
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
            //?----- no need to all this params ===================
            'id': id.toString(),
            'name': 'btoo',
            'lastname': 'ahmed'
          },
          //! send to ==================================
          //* Returns the default FCM token for this device.
          // 'to': await FirebaseMessaging.instance.getToken()
          // 'to': "certain token"
          //?= we reach topic through send notify brn ============
          'to': '/topics/weather'
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
      body: Column(
        children: [
          MaterialButton(
            onPressed: () async {
              await sendNotify("title", 'body', '1');
            },
            child: Text("send notify"),
          ), //! is better call them on init not as btn
          MaterialButton(
            onPressed: () async {
              await FirebaseMessaging.instance.subscribeToTopic('weather');
            },
            child: Text("send notify"),
          ),
          MaterialButton(
            onPressed: () async {
              await FirebaseMessaging.instance.unsubscribeFromTopic('weather');
            },
            child: Text("send notify"),
          ),
        ],
      ),
    );
  }
}
