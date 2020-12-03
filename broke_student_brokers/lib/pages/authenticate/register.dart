import 'package:flutter/material.dart';
import 'package:broke_student_brokers/services/auth.dart';
import 'package:flutter_svg/svg.dart';

ButtonStyle style = OutlinedButton.styleFrom(shape: StadiumBorder());

class RegisterEmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Enter an email' : null;
  }
}

class RegisterPasswordFieldValidator {
  static String validate(String value) {
    return value.length < 6
        ? 'Password must be at least 6 characters long'
        : null;
  }
}

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   // backgroundColor: Colors.teal[300],
      //   elevation: 0.0,
      //   // title: Text('Sign-Up to BrokeStudentBrokers'),
      //   actions: <Widget>[

      //   ],
      // ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/back.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ),
            ),
            Container(
              height: 200,
              child: Padding(
                  padding: EdgeInsets.only(right: 20, left: 20, top: 100),
                  child: Image.asset('assets/images/Group1.png')),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                          validator: RegisterEmailFieldValidator.validate,
                          onChanged: (val) {
                            setState(() => email = val);
                          }),
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        validator: RegisterPasswordFieldValidator.validate,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: StadiumBorder(),
                          side: BorderSide(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(
                                  () => error = 'Please enter a valid email');
                            }
                          }
                        },
                        child: Text('Register',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(height: 12.0),
                      Text(error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
