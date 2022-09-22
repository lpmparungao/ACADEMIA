// import 'package:flutter/material.dart';
// import 'package:sample1/databaseHelpers.dart';
// import 'package:sample1/schedule/User.dart';
// import 'package:sample1/schedule/scheduleModel.dart';
// import 'schedule.dart';

// class AddSchedule extends StatefulWidget {
//   final Function updateSchedList;
//   final ScheduleModel schedule;
//   AddSchedule({this.updateSchedList, this.schedule, });
    
//       static User theUser = new User();
//   //AddSchedule({Key key, this.title}) : super(key: key);
//   //final String title;
//   @override
//   _AddScheduleState createState() => _AddScheduleState();
// }

// class _AddScheduleState extends State<AddSchedule> {

//   final _formKey = GlobalKey<FormState>();
//   String _titleSched = '';
//   String _repeatSched = '';
//   String _prioritySched = '';
//   DateTime _dateSchedStart = DateTime.now();
//   DateTime _dateSchedEnd = DateTime.now();
//   TextEditingController _dateController = TextEditingController();

//   @override
//   void initState() { 
//     super.initState();

//     if (widget.schedule != null){
//       _titleSched = widget.schedule.titleSched;
//       _dateSchedStart = widget.schedule.dateSchedEnd;
//       _dateSchedEnd = widget.schedule.dateSchedEnd;
//       _repeatSched = widget.schedule.repeatSched;
//       _prioritySched = widget.schedule.prioritySched;
//     }

//     //_dateController.text = _dateFormatter.format(_date);
//   }
//   @override
//   void dispose(){
//     //_dateController.dispose();
//     super.dispose();
//   }

//   _delete() {
//     DatabaseHelper.instance.deleteTask(widget.schedule.idSched);
//     widget.updateSchedList();
//     Navigator.pop(context);
//   }

//   _submit() {
//     if (_formKey.currentState.validate()) {
//       _formKey.currentState.save();
//       print('$_titleSched, $_dateSchedStart, $_dateSchedEnd, $_prioritySched, $_repeatSched'); //to check if working
      
//       //insert the task to our user's database
//       ScheduleModel schedule = ScheduleModel(titleSched: _titleSched, dateSchedStart: _dateSchedStart, dateSchedEnd: _dateSchedEnd, repeatSched: _repeatSched, prioritySched: _prioritySched);
//       if (widget.schedule == null) {
//         schedule.statusSched = 0;
//         DatabaseHelper.instance.insertSched(schedule);
//       }else {
//         //update the task
//         schedule.idSched = widget.schedule.idSched;
//         schedule.statusSched = widget.schedule.statusSched;
//         DatabaseHelper.instance.updateSched(schedule);
//       }
//       widget.updateSchedList();
//       Navigator.pop(context);
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     TextEditingController taskNameController = new TextEditingController();
//     String texts = "";
//     return Scaffold(
//       body: GestureDetector(
//          onTap: () => FocusScope.of(context).unfocus(),
//       child: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Icon(
//                     Icons.arrow_back_rounded,
//                     size: 30.0,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 Text(
//                   'Add to schedule',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 40.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//               Text("Enter subject name"),
//               TextField(
//                 controller: taskNameController,
//                 onChanged: (text) {
//                   texts = text;
//                 },
//                 onEditingComplete: () {
//                   taskNameController.text = texts;
//                 },
//                 //textAlign: TextAlign.center,
//               ),
//               FlatButton(
//                 color: Color.fromRGBO(255, 226, 140, 0.49),
//                 child: Text("Add"),
//                 onPressed: () {
//                   if (taskNameController.text.length > 1) {
//                     addTaskName(taskNameController.text);
//                     _submit();
//                   }
//                 },
//               )
//             ],
//           )
//         ),
//     )
//    ));
//   }

//   void addTaskName(String name) {
//     // Should show a dialog or new window where one can specify the occurrence
//     print("This is the name: " + name);
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => SecondRoute()),
//     );
//   }
// }
// class SecondRoute extends StatefulWidget {
//   final Function updateSchedList;
//   final ScheduleModel schedule;
//   SecondRoute({this.updateSchedList, this.schedule, this.name});

//   String name;
//   // SecondRoute(String name) {
//   //   this.name = name;
//   // }
//   @override
//   _SecondRouteState createState() => _SecondRouteState(name);
// }

// class _SecondRouteState extends State<SecondRoute> {

//   final _formKey = GlobalKey<FormState>();
//   String _titleSched = '';
//   String _repeatSched = '';
//   String _prioritySched = '';
//   DateTime _dateSchedStart = DateTime.now();
//   DateTime _dateSchedEnd = DateTime.now();
//   TextEditingController _dateController = TextEditingController();
  
//   String taskName;
//   bool monday = false;
//   bool tuesday = false;
//   bool wednesday = false;
//   bool thursday = false;
//   bool friday = false;
//   bool saturday = false;
//   bool sunday = false;
//   List<int> days = [];
//   Future<TimeOfDay> timeFrom;
//   Future<TimeOfDay> timeTo;
//   bool repeats = false;
//   _SecondRouteState(String name) {
//     this.taskName = name;
//   }
//   TextStyle weedayStyle = TextStyle(fontFamily: 'Avenir', fontSize: 10, fontWeight: FontWeight.bold);
//   TextStyle titles = TextStyle(fontFamily: 'Avenir', fontSize: 20, fontWeight: FontWeight.bold);

//   _submit() {
//     if (_formKey.currentState.validate()) {
//       _formKey.currentState.save();
//       print('$_titleSched, $_dateSchedStart, $_dateSchedEnd, $_prioritySched, $_repeatSched'); //to check if working
      
//       //insert the task to our user's database
//       ScheduleModel schedule = ScheduleModel(titleSched: _titleSched, dateSchedStart: _dateSchedStart, dateSchedEnd: _dateSchedEnd, repeatSched: _repeatSched, prioritySched: _prioritySched);
//       if (widget.schedule == null) {
//         schedule.statusSched = 0;
//         DatabaseHelper.instance.insertSched(schedule);
//       }else {
//         //update the task
//         schedule.idSched = widget.schedule.idSched;
//         schedule.statusSched = widget.schedule.statusSched;
//         DatabaseHelper.instance.updateSched(schedule);
//       }
//       widget.updateSchedList();
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(taskName),
//       ),
//       body: Center(
//         child: Container(
//           margin: EdgeInsets.only(top: 0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Text('Repeats: ', style: titles,),
//             Container(
//               margin: EdgeInsets.only(top: 0, bottom: 100),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Container(
//                     child: Center(
//                       child: Column(
//                         children: <Widget>[
//                           Text('Monday', style: weedayStyle,),
//                           Checkbox(
//                             value: monday,
//                             onChanged: (value) {
//                               if (!this.days.contains(0)) {
//                                 this.days.add(0);
//                               } else {
//                                 this.days.remove(0);
//                               }
//                               setState(() {
//                                 monday = value;
//                               });
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     child: Center(
//                       child: Column(
//                         children: <Widget>[
//                           Text('Tuesday', style: weedayStyle,),
//                           Checkbox(
//                             value: tuesday,
//                             onChanged: (value) {
//                               if (!this.days.contains(1)) {
//                                 this.days.add(1);
//                               } else {
//                                 this.days.remove(1);
//                               }
//                               setState(() {
//                                 tuesday = value;
//                               });
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     child: Center(
//                       child: Column(
//                         children: <Widget>[
//                           Text('Wednesday', style: weedayStyle,),
//                           Checkbox(
//                             value: wednesday,
//                             onChanged: (value) {
//                               if (!this.days.contains(2)) {
//                                 this.days.add(2);
//                               } else {
//                                 this.days.remove(2);
//                               }
//                               setState(() {
//                                 wednesday = value;
//                               });
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     child: Center(
//                       child: Column(
//                         children: <Widget>[
//                           Text('Thursday', style: weedayStyle,),
//                           Checkbox(
//                             value: thursday,
//                             onChanged: (value) {
//                               if (!this.days.contains(3)) {
//                                 this.days.add(3);
//                               } else {
//                                 this.days.remove(3);
//                               }
//                               setState(() {
//                                 thursday = value;
//                               });
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     child: Center(
//                       child: Column(
//                         children: <Widget>[
//                           Text('Friday', style: weedayStyle,),
//                           Checkbox(
//                             value: friday,
//                             onChanged: (value) {
//                               if (!this.days.contains(4)) {
//                                 this.days.add(4);
//                               } else {
//                                 this.days.remove(4);
//                               }
//                               setState(() {
//                                 friday = value;
//                               });
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     child: Center(
//                       child: Column(
//                         children: <Widget>[
//                           Text('Saturday', style: weedayStyle,),
//                           Checkbox(
//                             value: saturday,
//                             onChanged: (value) {
//                               if (!this.days.contains(5)) {
//                                 this.days.add(5);
//                               } else {
//                                 this.days.remove(5);
//                               }
//                               setState(() {
//                                 saturday = value;
//                               });
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     child: Center(
//                       child: Column(
//                         children: <Widget>[
//                           Text('Sunday', style: weedayStyle,),
//                           Checkbox(
//                             value: sunday,
//                             onChanged: (value) {
//                               if (!this.days.contains(6)) {
//                                 this.days.add(6);
//                               } else {
//                                 this.days.remove(6);
//                               }
//                               setState(() {
//                                 sunday = value;
//                               });
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(30)),
//                   color: Color.fromRGBO(255, 226, 140, 0.49)
//                 ),
//               child: Builder(
//             builder: (context) => FlatButton(
//                   onPressed: () {
//                     timeFrom = showTimePicker(context: context, initialTime: TimeOfDay.now());
//                   },
//                   child: Text("Set Start time", style: TextStyle(fontFamily: 'Avenir', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
//                 ),
//               ),
//             ), 
//                 Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(30)),
//                   color: Color.fromRGBO(255, 226, 140, 0.49)
//                 ),
//                   child: Builder(
//                   builder: (context) => FlatButton(
//                   onPressed: () {
//                     timeTo = showTimePicker(context: context, initialTime: TimeOfDay.now());
//                   },
//                   child: Text("Set End time", style: TextStyle(fontFamily: 'Avenir', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
//                 ),
//               ),
//             ),
//             RaisedButton(
//               color: Color.fromRGBO(255, 226, 140, 0.49),
//               onPressed: () {
//                 if (this.days.length > 0 && this.timeFrom != null && this.timeTo != null) {
//                   createTask();
//                   _submit();
//                   Navigator.pop(context);
//                 }
//               },
//               child: Text('Create Task', style: TextStyle(fontFamily: 'Avenir', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
//               ),
//           ],
//         ),
//         )
//       )
//     );
//   }

//   void createTask() async {
//     for (int day in days) {
//       print(day);
//     }
//     DateTime rightNow = new DateTime.now();
//     DateTime timeStart;
//     DateTime timeEnd;

//     await timeFrom.then((value) => timeStart = new DateTime(rightNow.year, rightNow.month, rightNow.day, value.hour, value.minute));
//     print(timeStart.toString());
//     await timeTo.then((value) => timeEnd = new DateTime(rightNow.year, rightNow.month, rightNow.day, value.hour, value.minute));
//     print(timeEnd.toString());
//     List<DateTime> times = [];
//     times.add(timeStart);
//     times.add(timeEnd);
//     AddSchedule.theUser.createTask(this.taskName, this.days, times, this.repeats);
//     Navigator.of(context).pop();
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => Schedule()),
//     );
//   }
// }
