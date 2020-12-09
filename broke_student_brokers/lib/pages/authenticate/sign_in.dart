import 'package:broke_student_brokers/services/auth.dart';
import 'package:flutter/material.dart';

ButtonStyle style = OutlinedButton.styleFrom(shape: StadiumBorder());

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Enter an email' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.length < 6
        ? 'Password must be at least 6 characters long'
        : null;
  }
}

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/back.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                alignment: Alignment.topRight,
                child: FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
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
                    child: Image.asset('assets/images/Group1.png'))),
            Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                          decoration: InputDecoration(hintText: "Enter Email"),
                          key: Key('hint1'),
                          validator: EmailFieldValidator.validate,
                          onChanged: (val) {
                            setState(() => email = val);
                          }),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(hintText: "Enter Password"),
                        obscureText: true,
                        validator: PasswordFieldValidator.validate,
                        key: Key('hint2'),
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      OutlinedButton(
                        key: Key('loginbutton'),
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
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() =>
                                  error = 'Please enter valid credentials');
                            }
                          }
                        },
                        child: Text('Sign In',
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
