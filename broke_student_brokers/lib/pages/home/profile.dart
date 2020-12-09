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
            height: 170,
            child: AspectRatio(
              aspectRatio: 3,
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
                                    document['symbol'],
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
                                    document['submitted_at']
                                        .split('T')[1]
                                        .split('.')[0],
                                    // document['time'].toString(),
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
                                    // document['date'].toString(),
                                    document['submitted_at']
                                            .split('T')[0]
                                            .split('-')[2] +
                                        '-' +
                                        document['submitted_at']
                                            .split('T')[0]
                                            .split('-')[1] +
                                        '-' +
                                        document['submitted_at']
                                            .split('T')[0]
                                            .split('-')[0],

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
                                    right: 0, left: 20, top: 20, bottom: 0),
                                child: Text(
                                  'Order ID - ' + document['id'].toString(),
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
                                  document['status'] == 'new'
                                      ? 'Status : Ongoing'
                                      : 'Status : ' + document['status'],
                                  style: TextStyle(
                                      color: document['status'] == 'new'
                                          ? Color(0xffEA8559)
                                          // : Color(0xff92FF9A),
                                          : document['status'] == 'canceled'
                                              ? Colors.red
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
                                    right: 0, left: 20, top: 17, bottom: 0),
                                child: Text(
                                  // 'Created At : ' +
                                  //     document['created_at'].toString(),
                                  "Filled Quantity : " + document['filled_qty'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Roboto",
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 23, left: 0, top: 17, bottom: 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: document['status'] == 'new'
                                              ? Color(0xffEA8559)
                                              : Color(0xff92FF9A)),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15, left: 15, top: 2, bottom: 3),
                                    child: Text(
                                      document['side'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Roboto",
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15, left: 0, top: 17, bottom: 0),
                                child: Text(
                                  'Quantity : ' + document['qty'].toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Roboto",
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700),
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
            .doc(_auth.currentUser.uid.toString())
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text(' ');
          return ListView.builder(
            itemCount: snapshot.data['orders'].length,
            itemBuilder: (context, index) =>
                _listItemBuilder(context, snapshot.data['orders'][index]),
            itemExtent: 170,
          );
        },
      ),
    );
  }
}
