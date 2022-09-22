import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sample1/Navbar.dart';
import 'package:sample1/Reminder/reminderScreen.dart';
import 'package:sample1/calendar/calendarScreen.dart';
import 'package:sample1/profile/editProfileScreen.dart';
import 'package:sample1/profile/profileScreen.dart';
import 'package:sample1/Start.dart';
import 'package:sample1/Login.dart';
import 'package:sample1/Home/HomePage.dart';
import 'package:sample1/SignUp.dart';
import 'package:sample1/Attendance.dart';
import 'package:sample1/Settings.dart';
import 'package:sample1/flashcards/flashcardReviewer.dart';
import 'package:sample1/notes/screen/noteScreen.dart';
import 'package:sample1/reviewer/topicScreen.dart';
import 'package:sample1/schedule/schedule.dart';
import 'package:sample1/policies/Policies.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:sample1/todolist/todoScreen.dart';
import 'package:sample1/reviewer/reviewerScreen.dart';
import 'package:timezone/data/latest_all.dart' as tz;



void main() async { //change void to future
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      theme: ThemeData(
        
        primaryColor: Color(0xFFCDB193),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'assets/logo.png',
          ),
        nextScreen: Start(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Color(0xFFEEBAB2),
        duration: 2000,
      ),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => Login(),
        "SignUp": (BuildContext context) => SignUp(),
        "start": (BuildContext context) => Start(),
        "HomePage": (BuildContext context) => HomePage(),
        "Navbar": (BuildContext context) => Navbar(),
        "Profile": (BuildContext context) => Profile(),
        "Todolist": (BuildContext context) => TodoListScreen(),
        "Notes": (BuildContext context) => NoteList(),
        "Schedule": (BuildContext context) => ReminderScreen(),
        "Calendar": (BuildContext context) => Calendar(),
        "Attendance": (BuildContext context) => Attendance(),
        "Flashcard": (BuildContext context) => Flashcard(),
        "Policies": (BuildContext context) => Policies(),
        "Settings": (BuildContext context) => Settings(),
        "Reviewer": (BuildContext context) => ReviewerScreen(),
        "Topic": (BuildContext context) => TopicScreen(),
        "EditProfile": (BuildContext context) => EditProfile(),
      }
    );
    
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(title: Text('Home'),
      ),
      body: Center(),
    );
  }
}