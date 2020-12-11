import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:broke_student_brokers/pages/home/deposit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:broke_student_brokers/services/auth.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

final FirebaseAuth _authUser = FirebaseAuth.instance;
final AuthService _auth = AuthService();

class _SettingState extends State<Setting> {
  final AuthService _auth = AuthService();
  final FirebaseAuth _authUser = FirebaseAuth.instance;

  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController controllerOne = TextEditingController();
    TextEditingController controllerTwo = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("                    Edit Details",
                style: TextStyle(color: Color(0xffFF5D5D))),
            content: AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text("Name"),
                  ),
                  TextField(
                    controller: controllerOne,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text("Email"),
                  ),
                  TextField(
                    controller: controllerTwo,
                  ),
                ]),
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  _authUser.currentUser.updateProfile(
                      displayName: controllerOne.text.toString());
                  _authUser.currentUser
                      .updateEmail(controllerTwo.text.toString());
                  Navigator.of(context).pop(controllerOne.text.toString());

                  // print("USER DEETS");
                  // print(_authUser.currentUser);
                },
                elevation: 5.0,
                child: Text("Submit"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController depositController = TextEditingController();
    print("USER DEETS");
    print(_authUser.currentUser);
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('testStocks')
              .doc(_authUser.currentUser.uid.toString())
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text(' ');
            return SingleChildScrollView(
              child: Builder(
                builder: (context) => Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Container()),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => {
                              createAlertDialog(context).then((onValue) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("Updated Details")));
                              })
                            },
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 0, top: 10, right: 20),
                            child: Text(
                              'EDIT',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Roboto",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 60,
                              child: ClipOval(
                                child: SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: Image.network(
                                    "https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX25634105.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 0),
                                    child: Text(
                                      // 'Shaurya Srivastava',
                                      // _authUser.currentUser.email
                                      //     .split("@")[0]
                                      //     .toUpperCase(),
                                      _authUser.currentUser.displayName == '' ||
                                              _authUser.currentUser
                                                      .displayName ==
                                                  null
                                          ? _authUser.currentUser.email
                                              .split("@")[0]
                                              .toUpperCase()
                                          : _authUser.currentUser.displayName
                                              .toUpperCase(),

                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Roboto",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 2),
                                    child: Text(
                                      _authUser.currentUser.email,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Roboto",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(top: 2),
                                      child: Row(
                                        children: [
                                          Icon(FontAwesomeIcons.moneyCheckAlt),
                                          Text(
                                            '   | ' +
                                                '\$' +
                                                snapshot.data['balance']
                                                    .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Roboto",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 13),
                                child: Container(
                                  height: 485,
                                  child: AspectRatio(
                                    aspectRatio: 1.0,
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          color: Color(0xff37353B)),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 38, bottom: 20),
                                                child: Text(
                                                  'Select Amount',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Roboto",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: GestureDetector(
                                                  onTap: () => {},
                                                  child: Container(
                                                    height: 60,
                                                    child: AspectRatio(
                                                      aspectRatio: 1.6,
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          color:
                                                              Color(0xff92FF9A),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  top: 15),
                                                          child: Text(
                                                            '+' + '\$' + '100',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    "Roboto",
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: GestureDetector(
                                                  onTap: () => {},
                                                  child: Container(
                                                    height: 60,
                                                    child: AspectRatio(
                                                      aspectRatio: 1.6,
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          color:
                                                              Color(0xff92FF9A),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  top: 15),
                                                          child: Text(
                                                            '+' + '\$' + '200',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    "Roboto",
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: GestureDetector(
                                                  onTap: () => {},
                                                  child: Container(
                                                    height: 60,
                                                    child: AspectRatio(
                                                      aspectRatio: 1.6,
                                                      child: Container(
                                                          margin:
                                                              EdgeInsets.all(5),
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                            color: Color(
                                                                0xff92FF9A),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5,
                                                                    top: 15),
                                                            child: Text(
                                                              '+' +
                                                                  '\$' +
                                                                  '300',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      "Roboto",
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: GestureDetector(
                                                  onTap: () => {},
                                                  // {print("PRESSED 400")},
                                                  child: Container(
                                                    height: 60,
                                                    child: AspectRatio(
                                                      aspectRatio: 1.6,
                                                      child: Container(
                                                          margin:
                                                              EdgeInsets.all(5),
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                            color: Color(
                                                                0xff92FF9A),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5,
                                                                    top: 15),
                                                            child: Text(
                                                              '+' +
                                                                  '\$' +
                                                                  '400',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      "Roboto",
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                child: Container(
                                                  height: 60,
                                                  child: AspectRatio(
                                                    aspectRatio: 6.45,
                                                    child: Container(
                                                      margin: EdgeInsets.all(5),
                                                      decoration:
                                                          const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                        color:
                                                            Color(0xffCECECE),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(3),
                                                        child: TextField(
                                                          controller:
                                                              depositController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration: new InputDecoration(
                                                              border: new UnderlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              Color(0xffCECECE)))),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 28, bottom: 20),
                                            child: Text(
                                              'Choose a Payment Method',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Roboto",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  height: 60,
                                                  child: AspectRatio(
                                                    aspectRatio: 1.75,
                                                    child: Container(
                                                      margin: EdgeInsets.all(5),
                                                      decoration:
                                                          const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                        color: Colors.black,
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://paymentweek.com/wp-content/uploads/2017/08/paytm-logo-630x336.jpg"),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  height: 60,
                                                  child: AspectRatio(
                                                    aspectRatio: 1.75,
                                                    child: Container(
                                                      margin: EdgeInsets.all(5),
                                                      decoration:
                                                          const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                        color: Colors.black,
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://cdn.i.haymarketmedia.asia/?n=campaign-asia%2Fcontent%2F20110512020143_visa.jpg&h=570&w=855&q=100&v=20170226&c=1"),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  height: 60,
                                                  child: AspectRatio(
                                                    aspectRatio: 1.75,
                                                    child: Container(
                                                      margin: EdgeInsets.all(5),
                                                      decoration:
                                                          const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                        color: Colors.white,
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://static.dezeen.com/uploads/2016/07/mastercard-logo-redesign-pentagram_dezeen_1568_2.jpg"),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 20, bottom: 15),
                                            child: Text(
                                              'Pay',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Roboto",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  height: 70,
                                                  child: AspectRatio(
                                                    aspectRatio: 2.5,
                                                    child: GestureDetector(
                                                      onTap: () => {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'testStocks')
                                                            .doc(_authUser
                                                                .currentUser.uid
                                                                .toString())
                                                            .update({
                                                          'balance': snapshot
                                                                      .data[
                                                                  'balance'] +
                                                              double.parse(
                                                                  depositController
                                                                      .text)
                                                        })
                                                      },
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          color:
                                                              Color(0xffAAE6E8),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            top: 19,
                                                          ),
                                                          child: Text(
                                                            'DEPOSIT',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    "Roboto",
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      height: 70,
                                      child: AspectRatio(
                                        aspectRatio: 2.5,
                                        child: GestureDetector(
                                          onTap: () async {
                                            await _auth.signOut();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Color(0xffFF5D5D),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                top: 0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'LOG OUT',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Roboto",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4),
                                                    child: Icon(Icons.logout),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 200,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
