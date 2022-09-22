import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sample1/Home/HomePage.dart';
import 'package:sample1/forgotPass.dart';
import 'package:sample1/profile/animation.dart';
import 'package:flutter/material.dart';
import 'package:sample1/profile/editProfileScreen.dart';
import 'package:sample1/profile/input.dart';
import 'package:sample1/start.dart';
import 'package:icon_shadow/icon_shadow.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

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

  delete() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser.delete();
  }

  @override
  void initState() {
    this.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var formattedBirth = DateFormat('yMMMMd').format(textBirthdate);
    return Scaffold(
      //drawer: Navbar(),
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            child: !isloggedin
                ? _progress()
                : CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              child: IconShadowWidget(
                                Icon(
                                  Icons.arrow_back,
                                  size: 23,
                                  color: Colors.white,
                                ),
                                shadowColor: Colors.black,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => HomePage(),
                                  ),
                                );
                              },
                            ),
                            Spacer(),
                            GestureDetector(
                              child: IconShadowWidget(
                                Icon(
                                  Icons.mode_edit_outline,
                                  size: 23,
                                  color: Colors.white,
                                ),
                                shadowColor: Colors.black,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditProfile(),
                                  ),
                                );
                              },
                            ),
                            GestureDetector(
                              child: Stack(
                                children: <Widget>[
                                  // Stroked text as border.
                                  Text(
                                    ' Edit',
                                    style: TextStyle(
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 5.0,
                                        color: Colors.black,
                                      ),
                                    ],
                                    ),
                                  ),
                                  Text(
                                    ' Edit',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EditProfile(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        expandedHeight: 440,
                        backgroundColor: Colors.black,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          background: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imagePath == null
                                        ? AssetImage('assets/profile.jpg')
                                        : FileImage(File(imagePath)),
                                    fit: BoxFit.cover)),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      colors: [
                                    Colors.white,
                                    Colors.white.withOpacity(.1)
                                  ])),
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    FadeAnimation(
                                        1,
                                        Text(
                                          "${textName}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 40),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            FadeAnimation(
                                                1.2,
                                                Text(
                                                  textCourse == null
                                                      ? '<<No Course>>'
                                                      : '${textCourse}',
                                                  style: TextStyle(
                                                      color: Colors.grey[850],
                                                      fontSize: 16),
                                                )),
                                          ],
                                        ),
                                        //SizedBox(width: 100,),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            FadeAnimation(
                                              1.3,
                                              Text(
                                                  textLRN == null
                                                      ? '<<No Student Number>>'
                                                      : '${textLRN}',
                                                  style: TextStyle(
                                                      color: Colors.grey[850],
                                                      fontSize: 16,),
                                            ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FadeAnimation(
                                    1.6,
                                    Text(
                                      textDescription == null
                                          ? '<<No Description>>'
                                          : '${textDescription}',
                                      style: TextStyle(
                                        color: Colors.grey[850],
                                        height: 1.4,
                                        fontSize: 16,
                                      ),
                                    )),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    FadeAnimation(
                                      1.6,
                                      Icon(
                                        Icons.email,
                                        color: Color(0xFFFFB8AC),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FadeAnimation(
                                        1.6,
                                        Text(
                                          "${textEmail}",
                                          style: TextStyle(
                                              color: Color(0xFFFFB8AC),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 33),
                                    FadeAnimation(
                                        1.6,
                                        Text(
                                          "Email",
                                          style: TextStyle(
                                            color: Colors.grey[850],
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    FadeAnimation(
                                      1.6,
                                      Icon(
                                        Icons.phone,
                                        color: Color(0xFFFFB8AC),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FadeAnimation(
                                        1.6,
                                        Text(
                                          textNumber == null
                                              ? '<<No Contact Number>>'
                                              : '${textNumber}',
                                          style: TextStyle(
                                              color: Color(0xFFFFB8AC),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 33),
                                    FadeAnimation(
                                        1.6,
                                        Text(
                                          "Contact Number",
                                          style: TextStyle(
                                            color: Colors.grey[850],
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    FadeAnimation(
                                      1.6,
                                      Icon(
                                        Icons.cake,
                                        color: Color(0xFFFFB8AC),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FadeAnimation(
                                        1.6,
                                        Text(
                                          textBirthdate == null
                                              ? '<<No Birthdate>>'
                                              : '${textBirthdate}',
                                          style: TextStyle(
                                              color: Color(0xFFFFB8AC),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 33),
                                    FadeAnimation(
                                        1.6,
                                        Text(
                                          "Birthdate",
                                          style: TextStyle(
                                            color: Colors.grey[850],
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                FadeAnimation(
                                  1.6,
                                  Column(
                                    children: [
                                      Center(
                                        child: GestureDetector(
                                            child: Text(
                                              "Change Password",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.grey[850],
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ForgotPassword()));
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FadeAnimation(
                                  1.6,
                                  Column(
                                    children: [
                                      Center(
                                        child: GestureDetector(
                                            child: Text(
                                              "Delete Account",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.grey[850],
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onTap: () {
                                              return showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  title: Text(
                                                    "Delete Account",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.red[700],
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  content: Text(
                                                      "Are you sure you want to delete your account?"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        delete();
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Start()));
                                                      },
                                                      child: Text(
                                                        'Yes',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red[700]),
                                                      ),
                                                    ),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('No'))
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      )
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    await new Future.delayed(const Duration(seconds: 2));
    return true;
  }
}

Widget _progress() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          backgroundColor: Color(0xFFE28C7E),
          valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFF2E2D2)),
          strokeWidth: 10,
        ),
      ],
    ),
  );
}
