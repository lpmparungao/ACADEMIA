import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sample1/profile/input.dart';
import 'package:sample1/profile/profileScreen.dart';
import 'package:sample1/profile/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;
  DateTime _date = DateTime.now();

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

  // @override
  // void dispose() {
  //   textDescription;
  //   super.dispose();
  // }
  @override
  void initState() {
    this.getUser();
    //loadSharedPrefs();
    textBirthdateController.text = textBirthdate;
    loadData();
    super.initState();
  }

  PickedFile _imageFile;
  static ImagePicker _picker = ImagePicker();
  //controller
  // static final TextEditingController textNameController =
  //     TextEditingController();
  static final TextEditingController textCourseController =
      TextEditingController();
  static final TextEditingController textLRNController =
      TextEditingController();
  static final TextEditingController textDescriptionController =
      TextEditingController();
  // static final TextEditingController textEmailController =
  //     TextEditingController();
  static final TextEditingController textNumberController =
      TextEditingController();
  static final TextEditingController textBirthdateController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _date,
      lastDate: DateTime.now(),
      firstDate: DateTime(1900),
    );
    if (date != null && date != _date) {
      setState(() {
        textBirthdate = DateFormat('yMMMMd').format(date);
      });
      textBirthdateController.text = textBirthdate;
    }
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = prefs.getString('TestUser_Key');
    print("load info $json");

    if (json == null) {
      print('no data');
    } else {
      Map<String, dynamic> map = jsonDecode(json);
      print('map $map');

      final user1 = UserInfoPref.fromJson(map);
      print('Name: ${user1.userName}');
      print('Email: ${user1.userEmail}');
      print('Description: ${user1.userDescription}');
      print('LRN: ${user1.userLRN}');
      print('Course: ${user1.userCourse}');
      print('Number: ${user1.userNumber}');
    }
  }

  saveData() async {
    String textName = '${user.displayName}';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final testUser = UserInfoPref(
      userName: '$textName',
      userEmail: '$textEmail',
      userDescription: '$textDescription',
      userLRN: '$textLRN',
      userCourse: '$textCourse',
      userNumber: '$textNumber',
    );

    String json = jsonEncode(testUser);
    print("save info $json");
    prefs.setString('TestUser_Key', json);
  }

  cleardata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    print("Data cleared");
  }

  Widget _buildImage() {
    return Center(
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                color: CustomColors.menuBackgroundColor,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 8,
                  color: Colors.white,
                ),
              ),
              child: CircleAvatar(
                radius: 90.0,
                backgroundImage: imagePath == null
                    ? AssetImage('assets/profile.jpg')
                    : FileImage(File(imagePath)),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // border: Border.all(
                  //   width: 4,
                  //   color: Theme.of(context).scaffoldBackgroundColor,
                  // ),
                  color: Color(0xFFEEBAB2).withOpacity(.8),
                ),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => _buildSheet()),
                    );
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFEEBAB2),
            Color(0xFFF2E2D2),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        //borderRadius: BorderRadius.only( topRight: Radius.circular(20),
        //topLeft: Radius.circular(20)),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Text("Choose Profile Image",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera_rounded, color: Colors.white),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text('Camera',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white)),
              ),
              SizedBox(
                width: 15,
              ),
              TextButton.icon(
                icon: Icon(Icons.image_rounded, color: Colors.white),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text('Gallery',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white)),
              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
      imagePath = _imageFile.path;
    });
    Navigator.of(context).pop();
  }

  Widget _buildUserBirthdate() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 0,
      ),
      child: TextFormField(
        readOnly: true,
        controller: textBirthdateController,
        style: TextStyle(color: Colors.black, fontSize: 20),
        cursorColor: Colors.black,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Enter Birthdate';
          }
          return null;
        },
        onTap: _handleDatePicker,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: 'Birthdate',
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          focusColor: Colors.black,
          isDense: true,
          prefixIcon: Icon(
            Icons.cake,
            color: Color(0xFFFFB8AC),
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildUserLRN() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: TextFormField(
          controller: textLRNController,
          style: TextStyle(color: Colors.black, fontSize: 20),
          cursorColor: Colors.black,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Enter Student Number';
            }
            return null;
          },
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Student Number',
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            focusColor: Colors.black,
            isDense: true,
            prefixIcon: Icon(
              Icons.subtitles,
              color: Color(0xFFFFB8AC),
              size: 24,
            ),
          ),
          /////using shared preferences
          onChanged: (value) {
            setState(() {
              //userSave.userLRN = value;
              textLRN = value;
            });
          }),
    );
  }

  Widget _buildUserCourse() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      // decoration: BoxDecoration(
      //   color: CustomColors.menuBackgroundColor,
      //   borderRadius: BorderRadius.all(Radius.circular(30)),
      // ),
      child: TextFormField(
          controller: textCourseController,
          style: TextStyle(color: Colors.black, fontSize: 20),
          cursorColor: Colors.black,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Enter Course';
            }
            return null;
          },
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Course',
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            focusColor: Colors.black,
            isDense: true,
            prefixIcon: Icon(
              Icons.book,
              color: Color(0xFFFFB8AC),
              size: 24,
            ),
          ),
          /////using shared preferences
          onChanged: (value) {
            setState(() {
              textCourse = value;
            });
          }),
    );
  }

  Widget _buildUserDescription() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      // decoration: BoxDecoration(
      //   color: CustomColors.menuBackgroundColor,
      //   borderRadius: BorderRadius.all(Radius.circular(30)),
      // ),
      child: TextFormField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: textDescriptionController,
          style: TextStyle(color: Colors.black, fontSize: 20),
          cursorColor: Colors.black,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Enter Description';
            }
            return null;
          },
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Description',
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            focusColor: Colors.black,
            isDense: true,
            prefixIcon: Icon(
              Icons.description,
              color: Color(0xFFFFB8AC),
              size: 24,
            ),
          ),
          /////using shared preferences
          onChanged: (value) {
            setState(() {
              //userSave.userDescription = value;
              textDescription = value;
            });
          }),
    );
  }

  Widget _buildUserNumber() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: TextFormField(
          controller: textNumberController,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.black, fontSize: 20),
          cursorColor: Colors.black,
          validator: (String value) {
            if (value.isEmpty) {
              return 'Enter Contact Number';
            }
            return null;
          },
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Contact Number',
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            focusColor: Colors.black,
            isDense: true,
            prefixIcon: Icon(
              Icons.phone,
              color: Color(0xFFFFB8AC),
              size: 24,
            ),
          ),
          /////using shared preferences
          onChanged: (value) {
            setState(() {
              textNumber = value;
            });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFFFB8AC),
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Spacer(),
            Text(
              'Edit Profile',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            Spacer(),
            SizedBox(width: 50)
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          //child: SingleChildScrollView(
          child: !isloggedin
              ? _progress()
              : Form(
                  key: _formKey,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFB8AC),
                          ),
                        ),
                        Scaffold(
                          backgroundColor: Colors.transparent,
                          body: SingleChildScrollView(
                            //physics: BouncingScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 0, top: 0, right: 0),
                                    //height: height * 0.43,
                                    height: height + 50,
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        //double innerHeight = constraints.maxHeight;
                                        double innerWidth =
                                            constraints.maxWidth;
                                        return Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            Positioned(
                                              top: 120,
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Container(
                                                //height: (innerHeight + 400 ),
                                                width: innerWidth,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  130.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  0.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  130.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0.0)),
                                                  color: Colors.white,
                                                ),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 80),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Center(
                                                            child: Text(
                                                              '${textName}',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 22),
                                                            ),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Center(
                                                            child: Text(
                                                              '${user.email}',
                                                              //textEmail ?? "EMAIL",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 30),
                                                      _buildUserDescription(),
                                                      SizedBox(height: 13),
                                                      _buildUserLRN(),
                                                      SizedBox(height: 13),
                                                      _buildUserCourse(),
                                                      SizedBox(height: 13),
                                                      _buildUserNumber(),
                                                      SizedBox(height: 13),
                                                      _buildUserBirthdate(),
                                                      SizedBox(height: 30),
                                                      //_buildButton(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(width: 10.0),
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          30),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              primary:
                                                                  Colors.white,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              loadData();
                                                            },
                                                            child: Text(
                                                                "CANCEL",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    letterSpacing:
                                                                        2.2,
                                                                    color: Colors
                                                                        .black)),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              setState(() {
                                                              if (!_formKey
                                                                  .currentState
                                                                  .validate()) {
                                                                return;
                                                              }
                                                              _formKey
                                                                  .currentState
                                                                  .save();
                                                              saveData();
                                                              print(
                                                                  "Profile Saved");
                                                              loadData();
                                                              print(
                                                                  '${textName}');
                                                              print(
                                                                  '${textEmail}');
                                                              print(
                                                                  '${textDescription}');
                                                              print(
                                                                  '${textLRN}');
                                                              print(
                                                                  '${textCourse}');
                                                              print(
                                                                  '${textNumber}');
                                                              print(
                                                                  '${textBirthdate}');
                                                              Navigator.pop(
                                                                  context);
                                                              },
                                                              ); 
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary: Color(
                                                                  0xFFFFB8AC),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          30),
                                                              elevation: 2,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                            ),
                                                            child: Text(
                                                              " SAVE ",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      2.2,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          SizedBox(width: 20.0),
                                                        ],
                                                      ),
                                                      SizedBox(width: 20.0),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              left: 0,
                                              right: 0,
                                              child: Center(
                                                child: Container(
                                                  child: _buildImage(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //),
                ),
        ),
      ),
    );
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
