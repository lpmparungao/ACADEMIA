import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Attendance extends StatelessWidget {

  String subNow;
  @override
  Widget build(BuildContext context) {

    TextStyle def = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat.yMMMMd('en_US').format(DateTime.now());
    String formattedTime = DateFormat('HH:mm aa').format(now);
    return Scaffold(
      backgroundColor: Colors.grey[25],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Attendance'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text("Premium Account Only",textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red[700], fontSize: 18, fontWeight: FontWeight.bold),
                ),
                content: Text("This feature is available for premium users only, get yours now!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Okay',style: TextStyle(color: Colors.red[700]),
                    ),
                  ),
                ],
              ),
            );
          },
          label: Text('Import Schedule',style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  //fontWeight: FontWeight.w300,
                ),),
          icon: Icon(Icons.upload, color: Colors.black,),
          backgroundColor: Color(0xFF98BD91),
      ),
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 5,),
              Text(
                formattedDate + " — $formattedTime",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[600],
                  //fontWeight: FontWeight.w300,
                ),
              ),
              
              SizedBox(height: 10,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Container(
                        width: ((MediaQuery.of(context).size.width)/2) - 40,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color(0xFFE28C7E).withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                      child: Column(
                        children: <Widget>[
                      SizedBox(height: 10.0),
                      Text('0',
                            style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                      SizedBox(height: 10.0),
                      Text('Present',
                            style: TextStyle(color: Colors.grey[700], fontSize: 13,),
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
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                      child: Column(
                        children: <Widget>[
                      SizedBox(height: 10.0),
                      Text('0',
                            style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                      SizedBox(height: 10.0),
                      Text('Absent',
                            style: TextStyle(color: Colors.grey[700], fontSize: 13,),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'Current Class:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE28C7E).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12)),
                child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Course Code:", style: def),
                          SizedBox(height: 13.0),
                          Text("Course Name:", style: def),
                          SizedBox(height: 13.0),
                          Text("Time", style: def),
                          SizedBox(height: 13.0),
                          Text("Professor:", style: def),
                          SizedBox(height: 13.0),
                          Text("Status:", style: def),
                        ],
                      ),
                    ),
                  ),
                  height: 200.0,
                ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RaisedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Present',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600)),
                  ),
                  color: Color(0xFF98BD91),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    )
                  ),
                  onPressed: () {
                    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("Premium Account Only",textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red[700], fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        content: Text("This feature is available for premium users only, get yours now!"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Okay',style: TextStyle(color: Colors.red[700]),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Text(
                'Next Class:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE28C7E).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12)),
                child: SizedBox(
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Course Name:", style: def),
                          SizedBox(height: 22.0),
                          Text("Time", style: def),
                          SizedBox(height: 22.0),
                          Text("Status:", style: def),
                        ],
                      ),
                    ),
                  height: 150.0,
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
