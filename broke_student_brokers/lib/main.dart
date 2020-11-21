import 'package:flutter/material.dart';

import 'pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        accentColor: Color(0xFF73FC7D),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          bottomAppBarColor: Color(0xFF202020)),
      themeMode: ThemeMode.dark,
      home: Home(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'pages/home.dart';
// import 'pages/somethingWrong.dart';
// import 'pages/loading.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         // Initialize FlutterFire
//         future: _initialization,
//         builder: (context, snapshot) {
//           // Check for errors
//           if (snapshot.hasError) {
//             return somethingWrong();
//           }

//           // Application
//           if (snapshot.connectionState == ConnectionState.done) {
//             return MaterialApp(
//               title: 'Flutter Demo',
//               theme: ThemeData(
//                 brightness: Brightness.light,
//                 primarySwatch: Colors.blue,
//                 accentColor: Color(0xFF73FC7D),
//                 visualDensity: VisualDensity.adaptivePlatformDensity,
//               ),
//               darkTheme: ThemeData(
//                   brightness: Brightness.dark,
//                   primaryColor: Colors.black,
//                   scaffoldBackgroundColor: Colors.black,
//                   bottomAppBarColor: Color(0xFF202020)),
//               themeMode: ThemeMode.dark,
//               home: Home(),
//             );
//           }

//           //Otherwise while waiting
//           return loading();
//         });
//   }
// }
