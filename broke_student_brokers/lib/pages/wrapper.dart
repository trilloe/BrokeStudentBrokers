import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:broke_student_brokers/pages/home/home.dart';
import 'package:broke_student_brokers/pages/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
