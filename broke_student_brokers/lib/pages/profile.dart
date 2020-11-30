import 'package:broke_student_brokers/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map stocks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      children: [
        Text('Test'),
        MaterialButton(
          height: 50,
          minWidth: double.maxFinite,
          elevation: 0,
          onPressed: fetchData(),
          child: Text('Fetch'),
        ),
        Text(
          stocks['AMZN']['shareCount'].toString(),
        ),
        Text(
          stocks['AMZN']['initialHoldings'].toString(),
        ),
        Text(
          stocks['AMZN']['currentHoldings'].toString(),
        ),
      ],
    )));
  }

  fetchData() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('stocks');
    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        stocks = snapshot.docs[0].data();
      });
    });
  }
}
