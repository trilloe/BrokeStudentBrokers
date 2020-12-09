import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget _listItemBuilder(BuildContext context, Map document) {
    print('TEST: ${document}');

    return Container(
      child: Column(
        children: [
          Container(
            height: 200,
            child: AspectRatio(
              aspectRatio: 2.4,
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Color(0xff37353B)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 0, left: 0, top: 24, bottom: 12),
                  child: Column(
                    children: [
                      Table(
                        children: [
                          TableRow(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    'SYMBOL',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Roboto",
                                        fontSize: 11,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    'TIME',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Roboto",
                                        fontSize: 11,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    'DATE',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Roboto",
                                        fontSize: 11,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    document['ticker'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Roboto",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    document['time'].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Roboto",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    document['date'].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Roboto",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 0, left: 12, top: 20, bottom: 0),
                                child: Text(
                                  'Order ID - ' +
                                      document['orderid'].toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Roboto",
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15, left: 0, top: 20, bottom: 0),
                                child: Text(
                                  'Status : ' + document['status'],
                                  style: TextStyle(
                                      color: document['status'] == 'In Progress'
                                          ? Color(0xffEA8559)
                                          : Color(0xff92FF9A),
                                      fontFamily: "Roboto",
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 0, left: 12, top: 17, bottom: 0),
                                child: Text(
                                  'Created At : ' +
                                      document['createdat'].toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Roboto",
                                      fontSize: 11,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15, left: 0, top: 17, bottom: 0),
                                child: Text(
                                  'Quantity : ' +
                                      document['quantity'].toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Roboto",
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 0, left: 12, top: 7, bottom: 0),
                                child: Text(
                                  'Submitted At : ' +
                                      document['submittedat'].toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Roboto",
                                      fontSize: 11,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15, left: 0, top: 7, bottom: 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15, left: 15, top: 2, bottom: 3),
                                    child: Text(
                                      document['buyorsell'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Roboto",
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    print(_auth.currentUser.uid.toString());
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('testStocks')
            .doc("Main_Test")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text(' ');
          return ListView.builder(
            itemCount: snapshot.data['orders'].length,
            itemBuilder: (context, index) =>
                _listItemBuilder(context, snapshot.data['orders'][index]),
            itemExtent: 200,
          );
        },
      ),
    );
  }
}
