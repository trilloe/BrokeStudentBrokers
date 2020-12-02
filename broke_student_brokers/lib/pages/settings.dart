import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:broke_student_brokers/pages/deposit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Settings'),
      // ),
      body: SingleChildScrollView(
        child: Builder(
          builder: (context) => Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 390, top: 10, right: 0),
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => Deposit(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0, top: 10),
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
                              "https://i.pinimg.com/236x/a9/26/69/a926693a2583911df130247809c1c1db.jpg",
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
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'Shaurya Srivastava',
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
                                'shauryasrivastava14@gmail.com',
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
                              child: Text(
                                '+91 8860599488',
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
                                      '   | ' + '\$' + '100',
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
                                                fontWeight: FontWeight.w700),
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
                                          child: Container(
                                            height: 60,
                                            child: AspectRatio(
                                              aspectRatio: 1.75,
                                              child: Container(
                                                margin: EdgeInsets.all(5),
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Color(0xff92FF9A),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5, top: 15),
                                                  child: Text(
                                                    '+' + '\$' + '100',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: "Roboto",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700),
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
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Color(0xff92FF9A),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5, top: 15),
                                                  child: Text(
                                                    '+' + '\$' + '200',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: "Roboto",
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700),
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
                                                    color: Color(0xff92FF9A),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5, top: 15),
                                                    child: Text(
                                                      '+' + '\$' + '300',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Roboto",
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  )),
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
                                                    color: Color(0xff92FF9A),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5, top: 15),
                                                    child: Text(
                                                      '+' + '\$' + '400',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Roboto",
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),

                                        // Flexible(
                                        //   flex: 1,
                                        //   child: Container(
                                        //     height: 20,
                                        //   ),
                                        // ),
                                        // Flexible(
                                        //   flex: 1,
                                        //   child: Container(
                                        //     height: 20,
                                        //   ),
                                        // ),
                                        // Flexible(
                                        //   flex: 1,
                                        //   child: Container(
                                        //     height: 20,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 15),
                                          child: Container(
                                            height: 60,
                                            child: AspectRatio(
                                              aspectRatio: 7,
                                              child: Container(
                                                margin: EdgeInsets.all(5),
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Color(0xffCECECE),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(3),
                                                  child: TextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: new InputDecoration(
                                                        border: new UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xffCECECE)))),
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .none),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Padding(
                                          //   padding: EdgeInsets.only(
                                          //       top: 20, bottom: 20),
                                          //   child: Text(
                                          //     'Select Amount',
                                          //     textAlign: TextAlign.center,
                                          //     style: TextStyle(
                                          //         color: Colors.white,
                                          //         fontFamily: "Roboto",
                                          //         fontSize: 14,
                                          //         fontWeight: FontWeight.w700),
                                          //   ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 28, bottom: 20),
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
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
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
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
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
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
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
                                      padding:
                                          EdgeInsets.only(top: 20, bottom: 15),
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
                                                  print("Tapped on container")
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.all(5),
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    color: Color(0xffAAE6E8),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 19,
                                                    ),
                                                    child: Text(
                                                      'DEPOSIT',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "Roboto",
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700),
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
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
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
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 4),
                                            child: Icon(Icons.logout),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
