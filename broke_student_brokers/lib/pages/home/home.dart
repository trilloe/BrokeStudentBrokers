import 'package:broke_student_brokers/pages/home/chat.dart';
import 'package:broke_student_brokers/pages/home/dashboard.dart';
import 'package:broke_student_brokers/pages/home/profile.dart';
import 'package:broke_student_brokers/pages/home/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Properties
  int currentTab = 0;
  final List<Widget> screens = [
    Dashboard(),
    Chat(),
    Profile(),
    Setting(),
  ];

  // Active Pages ( Tab )

  Widget currentScreen = Dashboard();

  final PageStorageBucket bucket = PageStorageBucket();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool bot_on = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(height: 80),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('testStocks')
              .doc(_auth.currentUser.uid.toString())
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text(' ');
            // print('snapshot: ${snapshot.data['botState']}');
            bot_on = snapshot.data['botState'];
            // print('bot_on= $bot_on');
            return PageStorage(
              child: currentScreen,
              bucket: bucket,
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.power_settings_new_outlined),
        backgroundColor: bot_on ? Color(0xFF73FC7D) : Colors.red,
        onPressed: () {
          setState(() {
            bot_on = !bot_on;
            try {
              FirebaseFirestore.instance
                  .collection('testStocks')
                  .doc(_auth.currentUser.uid.toString())
                  .update({'botState': bot_on});
            } catch (e) {
              print(e.toString());
            }
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  MaterialButton(
                    minWidth: 100,
                    onPressed: () {
                      setState(() {
                        currentScreen = Dashboard();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_filled,
                          color: currentTab == 0
                              ? Color(0xFF73FC7D)
                              : Colors.white,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 100,
                    onPressed: () {
                      setState(() {
                        currentScreen = Chat();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.explore,
                          color: currentTab == 1
                              ? Color(0xFF73FC7D)
                              : Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    minWidth: 100,
                    onPressed: () {
                      setState(() {
                        currentScreen = Profile();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_rounded,
                          color: currentTab == 2
                              ? Color(0xFF73FC7D)
                              : Colors.white,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 100,
                    key: Key("toSetting"),
                    onPressed: () {
                      setState(() {
                        currentScreen = Setting();

                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_red_eye_outlined,
                          color: currentTab == 3
                              ? Color(0xFF73FC7D)
                              : Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  CustomAppBar({Key key, @required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 25),
            child: Container(
              height: this.height,
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: IconButton(
                        alignment: Alignment.centerLeft,
                        icon: SvgPicture.asset('assets/images/BSB_Logo.svg'),
                        onPressed: () {},
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.account_circle),
                      onPressed: () {},
                    ),
                  ]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
