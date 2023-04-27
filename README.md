# wah_firebase

# it have some services as :
1. authentication
2. cloud fire store  == [CRUD]
3. firebase cloud messaging
4. cloud storage == [Upload and Download]
5. finally build app notes project

# packages we need:
 # add
  jiffy: ^6.1.0
  image_picker: ^0.8.7+4
  http: ^0.13.0
  shared_preferences: ^2.0.3
  firebase_core: ^2.10.0
  firebase_storage: ^11.1.1
  cloud_firestore: ^4.5.2
  firebase_messaging: ^14.4.1
  firebase_auth: ^4.2.2
  awesome_dialog: ^3.0.2
  dropdown_search: ^5.0.6

dev_dependencies:
  # add
  flutter_launcher_icons: ^0.13.1
  flutter_native_splash: ^2.2.19
  flutter_test:
    sdk: flutter
# icons
flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "images/logo.png"

# splash
flutter_native_splash:
  color: "#42a5f5"
  image: images/splash.png
  android_gravity: fill
  flutter_lints: ^2.0.0

# Overviews
- Authentication:-
Firebase Authentication provides backend services & easy-to-use SDKs to authenticate users to your app. It supports authentication using passwords, phone numbers, popular federated identity providers like Google, Facebook and Twitter, and more.

- Cloud Firestore:-
Firestore is a flexible, scalable NoSQL cloud database to store and sync data. It keeps your data in sync across client apps through realtime listeners and offers offline support so you can build responsive apps that work regardless of network latency or Internet connectivity.

- Firebase Cloud Messaging:-
Firebase Cloud Messaging (FCM) is a cross-platform messaging solution that lets you reliably send messages at no cost.
Using FCM, you can notify a client app that new email or other data is available to sync. You can send notification messages to drive user re-engagement and retention. For use cases such as instant messaging, a message can transfer a payload of up to 4 KB to a client app.

- Cloud Storage:-
Cloud Storage is designed to help you quickly and easily store and serve user-generated content, such as photos and videos.

- Core:-
The firebase_core plugin is responsible for connecting your Flutter app to your Firebase project. The plugin must be installed and initialized before the usage of any other FlutterFire plugins. It provides basic functionality such as:

Initializing FlutterFire.
Creating Secondary Firebase App Instances.

- Cloud Functions for Firebase:-
Cloud Functions for Firebase let you automatically run backend code in response to events triggered by Firebase features and HTTPS requests. Your code is stored in Google's cloud and runs in a managed environment. There's no need to manage and scale your own servers.

- ODM:-
The Object Document Mapper or ODM is an interface that treats a document as a tree structure wherein each node is an object representing a part of the document.
ODM methods allow programmatic access to the tree making it possible to change the structure, style or content of a document.


# Auth
from authentication choose => Sign in methods
[1] #   f i r e b a s e _ w a h  
 