import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sample1/profile/input.dart';
import 'package:sample1/start.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  //final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        //Navigator.of(context).pushReplacementNamed("start");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Start()));
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;

    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //key: _formKey,
      child: Material(
        //color: Colors.transparent,//Color(0xFFEEBAB2),
        child: Container(
          // child: SafeArea(
          //   child: !isloggedin? CircularProgressIndicator(
          //     backgroundColor: Color(0xFFE28C7E),
          //     valueColor:
          //         new AlwaysStoppedAnimation<Color>(Color(0xFFF2E2D2)),
          //     strokeWidth: 10,
              
          //   )
          //       :  
          // decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //           Color(0xFFEEBAB2),
          //           Color(0xFFF2E2D2),
          //         ],
          //       )
          //     ),
          child: ListView( //remove child if may progress
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFEEBAB2),
                    Color(0xFFF2E2D2),
                  ],
                )),
                height: 105,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFFEEBAB2),
                  ),
                  child: Text('ACADEMIA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      )),
                ),
              ),
              UserAccountsDrawerHeader(
                accountName: Text("${textName}"),
                //accountName: Text("name"),
                accountEmail: Text("${textEmail}"),
                //accountEmail: Text("email"),
                currentAccountPicture: CircleAvatar(
                  radius: 30,
                  backgroundImage: imagePath == null
                    ? AssetImage('assets/profile.jpg')
                    : FileImage(File(imagePath)),
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
              // Divider(
              //   color: Colors.black,
              //   height: 0,
              //   thickness: 1,
              //   indent: 10,
              //   endIndent: 10,
              // ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () => Navigator.of(context).pushNamed("HomePage"),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () => Navigator.of(context).pushNamed("Profile"),
                //onTap: ()=> null, //print('Home'),
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text('To-do List'),
                onTap: () => Navigator.of(context).pushNamed("Todolist"),
              ),
              ListTile(
                leading: Icon(Icons.notes),
                title: Text('Notes'),
                onTap: () => Navigator.of(context).pushNamed("Notes"),
              ),
              ListTile(
                leading: Icon(Icons.schedule),
                title: Text('Schedule'),
                onTap: () => Navigator.of(context).pushNamed("Schedule"),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Calendar'),
                onTap: () => Navigator.of(context).pushNamed("Calendar"),
              ),
              ListTile(
                leading: Icon(Icons.assignment_turned_in_sharp),
                title: Text('Attendance'),
                onTap: () => Navigator.of(context).pushNamed("Attendance"),
              ),
              ListTile(
                leading: Icon(Icons.rate_review_outlined),
                title: Text('Reviewer'),
                onTap: () => Navigator.of(context).pushNamed("Topic"),
              ),
              Divider(
                height: 30,
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: Text('Policies'),
                onTap: () => Navigator.of(context).pushNamed("Policies"),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () => Navigator.of(context).pushNamed("Settings"),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: signOut,
              ),
            ],
          ),
        ),
        ),
      
    );
  }
}
