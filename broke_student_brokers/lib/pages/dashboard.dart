import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(height: 100),
      body: Container(
        width: 1000,
        height: 1000,
        child: SvgPicture.asset('assets/images/BSB_Logo.svg'),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar({Key key, @required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey[300],
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.all(5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: IconButton(
                        alignment: Alignment.bottomLeft,
                        icon: SvgPicture.asset('assets/images/BSB_Logo.svg'),
                        onPressed: () {},
                      ),
                    ),
                    // Expanded(
                    //   child: Container(
                    //     color: Colors.white,
                    //     child: TextField(
                    //       decoration: InputDecoration(
                    //         hintText: "Search",
                    //         contentPadding: EdgeInsets.all(10),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    IconButton(
                      icon: Icon(Icons.verified_user),
                      onPressed: () => null,
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
