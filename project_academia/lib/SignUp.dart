import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:sample1/Login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  String _email, _password, _name; 

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "HomePage");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          await _auth.currentUser.updateProfile(displayName: _name);
        }
      } catch (e) {
        showError(e.message);
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  navigateToLogin() async {
    Navigator.pushReplacementNamed(context, "Login");
  }
  navigateToPolicies() async {
    Navigator.pushReplacementNamed(context, "Policies");
  }
  // navigateToHomePage() async {
  //   Navigator.pushReplacementNamed(context, "HomePage");
  // }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
    onWillPop: _onBackPressed,
    child: new Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      child: Container(
          child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 8/9)),
          Container(
            height: MediaQuery.of(context).size.height - ((MediaQuery.of(context).size.height * 5/7)+10),
            child: Image(
              image: AssetImage("assets/iconLog.png"),
              fit: BoxFit.contain,
            ),
          ),
          Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Enter Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Name',
                          filled: true,
                          hoverColor: Color(0xFFEEBAB2),
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                          ),
                          prefixIcon: Icon(Icons.person)
                      ),
                      onSaved: (input) => _name = input,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Enter Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          hoverColor: Color(0xFFEEBAB2),
                          isDense: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)
                          ),
                          prefixIcon: Icon(Icons.email)
                      ),
                      onSaved: (input) => _email = input,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: TextFormField(
                      validator: (input) {
                        if (input.length < 6) {
                          return 'Provide Minimum 6 Character';
                        }
                        return null;
                      },
                      obscureText: !this._showPassword,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          hoverColor: Color(0xFFEEBAB2),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: this._showPassword ? Colors.blue : Colors.grey,
                              ),
                              onPressed: () {
                              setState(() => this._showPassword = !this._showPassword);
                              },
                          ),
                      ),
                      //obscureText: true,
                      onSaved: (input) => _password = input,
                    ),
                      
                  ),
                  SizedBox(height: 20.0),
                  Padding(padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text('Note: Name and Email can not be changed after signing up.',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  ),
                  SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed: signUp,
                    child: Text(
                      'SIGNUP',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                        primary: Color(0xFFE28C7E),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                  ),
                  SizedBox(height: 10.0),
                Container(
                  alignment: FractionalOffset.center,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      GestureDetector(
                        child: Text("Sign in here.",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.indigoAccent, fontSize: 15)),
                        onTap: navigateToLogin,
                      )
                    ],
                  )
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text('By signing up, You agree to Academia Terms and Conditions.',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                  onTap: navigateToPolicies,
                ),
                SizedBox(height: 10.0),
                ],
              ),
            ),
          )
        ],
      )),
    ),),);
  }
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Do you want to exit the App'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false); //Will not exit the App
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                exit(0);//Will exit the App
              },
            )
          ],
        );
      },
    ) ?? false;
  }
}
