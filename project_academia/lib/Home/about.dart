import 'package:flutter/material.dart';
import 'package:sample1/Home/HomePage.dart';


class About extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 80),
            Text(
              '',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
            //Navigator.pop(context);
          },
        ),
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      ),
      body: Container(
        child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 100,
                child: Image(
                image: AssetImage("assets/logo.png"),
                fit: BoxFit.contain,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Center(
                child: Text('Welcome to ACADEMIA!',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Text('Academia is mainly designed for students at online schools who '+ 
                  'do not have a single platform for the distribution of academic '+ 
                  'workload. It can be overwhelming for students to monitor the ' +
                  'submissions, exams, and classes when there are multiple platforms '+
                  'that have to be checked. Academia is intended to help students in '+
                  'organizing all academic workload in just one platform. Having work '+
                  'organized has been proven to improve productivity. This is '+
                  'especially helpful now during the pandemic where most of people '+
                  'are forced to adapt to online classes. Students can easily get '+
                  'distracted with the number of things which can be done through the '+
                  'internet. Having an all-in-one organizer application for students can '+
                  'increase productivity and help in handling the overwhelming amount '+
                  'of academic workload.',
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0,right: 25.0, bottom: 25.0),
              child: Center(
                child: Text('©2021 Tech Intellect. Castronuevo, Jurie | Chua, Stephen | Morales, Kristelle | Parungao, Lance.'+ 
                  ' Computer Engineering Students from Polytechnic University of the Philippines Sta. Mesa, Manila. All rights reserved.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
