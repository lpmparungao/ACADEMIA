import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:path/path.dart';
import 'package:sample1/Attendance.dart';
import 'package:intl/intl.dart';
import 'package:sample1/Home/about.dart';
import 'package:sample1/Reminder/reminderScreen.dart';
import 'package:sample1/calendar/calendarScreen.dart';
import 'package:sample1/notes/screen/noteScreen.dart';
import 'package:sample1/policies/policiesHome.dart';
import 'package:sample1/profile/input.dart';
import 'package:sample1/profile/profileScreen.dart';
import 'package:sample1/reviewer/reviewerScreen.dart';
import 'package:sample1/todolist/sharedTodo.dart';
import 'package:sample1/todolist/todoScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //int _currentIndex = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> Navbar()));
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
        textName = '${user.displayName}';
        textEmail = '${user.email}';
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
    return new WillPopScope(
    onWillPop: _onBackPressed,
    child: new Scaffold(
      //drawer: Navbar(),
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFE28C7E),
        elevation: 0,
        actions: <Widget>[
          new Container(),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              signOut();
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20, top: 15),
              color: Color(0xFFE28C7E),
              alignment: FractionalOffset.center,
              child: new Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    DateFormat.yMMMMd('en_US').format(DateTime.now()),
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5), fontSize: 17),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    DateFormat.EEEE().format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8 * 2.5),
              // It will cover 20% of our total height
              height: ((MediaQuery.of(context).size.height)) * 0.2,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 0,
                    ),
                    height: (MediaQuery.of(context).size.height) * 0.2 - 27,
                    decoration: BoxDecoration(
                      color: Color(0xFFE28C7E),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                textName == null
                                    ? 'Loading...'
                                    : 'Hi ${textName}!',
                                //overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Spacer(),
                              //Image.asset("assets/images/logo.png")
                              GestureDetector(
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: imagePath == null
                                      ? AssetImage('assets/profile.jpg')
                                      : FileImage(File(imagePath)),
                                ),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Profile(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Color(0xFFE28C7E),
                          child: new Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                textCourse == null || textLRN == null
                                    ? '<<No Course>>' +
                                        '\n' +
                                        '<<No Student Number>>'
                                    : '${textCourse}' + '\n' + '${textLRN}',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Color(0xFFE28C7E).withOpacity(0.23),
                            ),
                          ],
                        ),
                        child: Text('ACADEMIA'),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => About()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Tasks Overview",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              //textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Container(
                    width: ((MediaQuery.of(context).size.width)/2) - 40,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFE28C7E).withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        Text(
                          textCountFinished == null
                              ? '0'
                              : '${textCountFinished}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Finished Tasks',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: ((MediaQuery.of(context).size.width)/2) - 40,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFE28C7E).withOpacity(0.3),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        Text(
                          textCountPending == null
                              ? '0'
                              : '${textCountPending}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Pending Tasks',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  GestureDetector(
                    child: Container(
                      height: 120.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15.0),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('icons/profile.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Profile',
                            style: TextStyle(color: Colors.grey[700]),
                          )
                        ],
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Profile(),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    child: Container(
                      height: 120.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15.0),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('icons/todo.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Todo List',
                            style: TextStyle(color: Colors.grey[700]),
                          )
                        ],
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TodoListScreen(),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    child: Container(
                      height: 120.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15.0),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('icons/notes.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Notes',
                            style: TextStyle(color: Colors.grey[700]),
                          )
                        ],
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NoteList(),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    child: Container(
                      height: 120.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15.0),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('icons/reviewer.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Reviewer',
                            style: TextStyle(color: Colors.grey[700]),
                          )
                        ],
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReviewerScreen(),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    child: Container(
                      height: 120.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15.0),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('icons/calendar.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Calendar',
                            style: TextStyle(color: Colors.grey[700]),
                          )
                        ],
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Calendar(),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    child: Container(
                      height: 120.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15.0),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('icons/schedule.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Schedule',
                            style: TextStyle(color: Colors.grey[700]),
                          )
                        ],
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReminderScreen(),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    child: Container(
                      height: 120.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15.0),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 10),
                          Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('icons/attendance.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Attendance',
                            style: TextStyle(color: Colors.grey[700]),
                          )
                        ],
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Attendance(),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
            // SizedBox(height: 20.0),
            // Container(
            //   height: 70,
            //   width: (MediaQuery.of(context).size.width) - 40,
            //   decoration: BoxDecoration(
            //       color: Color(0xFFE28C7E).withOpacity(0.3),
            //       borderRadius: BorderRadius.all(Radius.circular(10))),
            //   child: Column(
            //     children: <Widget>[
            //       SizedBox(height: 10.0),
            //       Text(
            //         'Upcoming Events',
            //         style: TextStyle(
            //           color: Colors.grey[700],
            //           fontSize: 13,
            //         ),
            //         textAlign: TextAlign.center,
            //       ),
            //       Divider(),
            //     ],
            //   ),
            // ),
            SizedBox(height: 20.0),
            Container(
              height: 190,
              width: (MediaQuery.of(context).size.width) - 40,
              decoration: BoxDecoration(
                  color: Color(0xFFE28C7E).withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Text(
                    'Schedule',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Divider(),
                  Spacer(),
                  Text(
                    'Schedule Not Available.',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              child: Text(
                'Academia. All Rights Reserved (2021)' + '\n',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PoliciesHome(),
                ),
              ),
            ),
          ],
        ),
      )),)
    );
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


