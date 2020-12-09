import 'package:broke_student_brokers/pages/home/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:broke_student_brokers/services/auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(child: Text('Profile Placeholder'));
//   }
// }

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
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: ListView.builder(
//       itemCount: _transactions.length,
//       itemExtent: 200.0,
//       itemBuilder: _listItemBuilder,
//     ));
//   }
// }

  // Stream<QuerySnapshot> getUserCurrentHoldings(BuildContext context) async* {
  //   final uid = await Provider.of(context).auth.getCurrentUID();
  //   yield* FirebaseFirestore.instance
  //       .collection('testStocks')
  //       .doc(uid)
  //       .collection('currentHoldings')
  //       .snapshots();
  // }

  // getUID(BuildContext context) async {
  //   return await Provider.of(context).auth.getCurrentUID();
  // }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    print(_auth.currentUser.uid.toString());
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            // .collection('TransactionInfo')
            .collection('testStocks')
            .doc("Main_Test")
            .snapshots(),
        builder: (context, snapshot) {
          print('snapshot: ${snapshot.data['orders']}');

          if (!snapshot.hasData) return const Text('Loading...');
          // List Data = snapshot.data.docs[2]['orders'];
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

// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//               child: Column(
//                 children: [
//                   Container(
//                       height: 230,
//                       child: AspectRatio(
//                         aspectRatio: 2.25,
//                         child: Container(
//                           margin: EdgeInsets.all(10),
//                           decoration: const BoxDecoration(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(18),
//                               ),
//                               color: Color(0xff202020)),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 right: 16.0, left: 12.0, top: 24, bottom: 12),

//                             child: Align(
//                               alignment: Alignment.topLeft,
//                               child: Text('transaction'),
//                               alignment: Alignment.topRight,
//                               child: Text('transaction'),
//                             ),

//                           ),
//                         ),
//                       )),

//                 ],
//               ),
//             );
//   }
// }

// class Transaction {
//   const Transaction(
//       {this.name,
//       this.time,
//       this.date,
//       this.orderid,
//       this.createdat,
//       this.submittedat,
//       this.status,
//       this.quantity,
//       this.buyorsell});

//   final String name;
//   final String time;
//   final String date;
//   final String orderid;
//   final String createdat;
//   final String submittedat;
//   final String status;
//   final String quantity;
//   final String buyorsell;
// }

// final List<Transaction> _transactions = <Transaction>[
//   Transaction(
//       name: 'GOOGL',
//       time: '16:50:32',
//       date: '10/12/2020',
//       orderid: '87456928459285',
//       createdat: '2020-11-06T16:49:50.179665z',
//       submittedat: '2020-11-06T16:50:32.179665z',
//       status: 'In Progress',
//       quantity: '5',
//       buyorsell: 'SELL'),
//   Transaction(
//       name: 'AMZN',
//       time: '16:48:32',
//       date: '10/12/2020',
//       orderid: '87456928459287',
//       createdat: '2020-11-06T16:47:00.179665z',
//       submittedat: '2020-11-06T16:48:00.179665z',
//       status: 'Completed',
//       quantity: '5',
//       buyorsell: 'BUY'),
//   Transaction(
//       name: 'AMZN',
//       time: '16:48:32',
//       date: '10/12/2020',
//       orderid: '87456928459287',
//       createdat: '2020-11-06T16:47:00.179665z',
//       submittedat: '2020-11-06T16:48:00.179665z',
//       status: 'Completed',
//       quantity: '5',
//       buyorsell: 'BUY'),
//   Transaction(
//       name: 'AMZN',
//       time: '16:48:32',
//       date: '10/12/2020',
//       orderid: '87456928459287',
//       createdat: '2020-11-06T16:47:00.179665z',
//       submittedat: '2020-11-06T16:48:00.179665z',
//       status: 'Completed',
//       quantity: '5',
//       buyorsell: 'BUY'),
//   Transaction(
//       name: 'AMZN',
//       time: '16:48:32',
//       date: '10/12/2020',
//       orderid: '87456928459287',
//       createdat: '2020-11-06T16:47:00.179665z',
//       submittedat: '2020-11-06T16:48:00.179665z',
//       status: 'Completed',
//       quantity: '5',
//       buyorsell: 'BUY'),
// ];
