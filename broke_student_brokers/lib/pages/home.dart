import 'package:broke_student_brokers/pages/chat.dart';
import 'package:broke_student_brokers/pages/dashboard.dart';
import 'package:broke_student_brokers/pages/profile.dart';
import 'package:broke_student_brokers/pages/settings.dart';
import 'package:flutter/material.dart';

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
    Settings(),
  ];

  // Active Pages ( Tab )

  Widget currentScreen = Dashboard();

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.power_settings_new_outlined),
        backgroundColor: Color(0xFF73FC7D),
        onPressed: () {},
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
                // mainAxisAlignment: MainAxisAlignment,
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
                        // Text(
                        //   'Dashboard',
                        //   style: TextStyle(
                        //       color:
                        //           currentTab == 0 ? Colors.blue : Colors.grey),
                        // )
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
                        // Text(
                        //   'Chats',
                        //   style: TextStyle(
                        //       color:
                        //           currentTab == 1 ? Colors.blue : Colors.grey),
                        // )
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
                        // Text(
                        //   'Profile',
                        //   style: TextStyle(
                        //       color:
                        //           currentTab == 2 ? Colors.blue : Colors.grey),
                        // )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 100,
                    onPressed: () {
                      setState(() {
                        currentScreen = Settings();
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
                        // Text(
                        //   'Settings',
                        //   style: TextStyle(
                        //       color:
                        //           currentTab == 3 ? Colors.blue : Colors.grey),
                        // )
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
