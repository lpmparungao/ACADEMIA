import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'ConfirmEmail.dart';

class ForgotPassword extends StatefulWidget {
  static String id = 'forgot-password';
 final String message =
      "An email has just been sent to you, Click the link provided to complete password reset";

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _auth = FirebaseAuth.instance;
  User user;

  final _formKey = GlobalKey<FormState>();
  String _email;

  _passwordReset() async {
    try {
      _formKey.currentState.save();
      final user = await _auth.sendPasswordResetEmail(email: _email);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) {
      //     return ConfirmEmail(message: widget.message,);
      //   }),
      // );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios_new_outlined, 
                    size: 18,
                    color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 10,),
                  GestureDetector(
                  child: Text(
                    'back',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  onTap: () => Navigator.pop(context),
                ),],
              ),
              SizedBox(height: 230,),
              Text(
                'Email Your Email',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              TextFormField(
                onSaved: (newEmail) {
                  _email = newEmail;
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(
                    Icons.mail,
                    color: Color(0xFFFFB8AC),
                  ),
                  errorStyle: TextStyle(color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Send Email'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFFB8AC)
                ),
                onPressed: () {
                  _passwordReset();
                  print(_email);
                },
              ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.white,
              //     onPrimary: Colors.black
              //   ),
              //   child: Text('Sign In'),
              //   onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
              //   },
              // ),
              SizedBox(height: 250,),
            ],
          ),
        ),
      ),
    );
  }
}