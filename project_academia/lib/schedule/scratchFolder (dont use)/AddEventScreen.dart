// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:sample1/schedule/scratchFolder%20(dont%20use)/schedModel.dart';

// import 'sched_db.dart';

// class AddEventScreen extends StatefulWidget {
//   final Sched sched;

//   AddEventScreen({this.sched});

//   @override
//   _AddEventScreenState createState() => _AddEventScreenState();
// }

// class _AddEventScreenState extends State<AddEventScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String _title = '';
//   bool _recurrent = false;
//   String _recurrence;
//   DateTime _recurrenceEnd = DateTime.now();
//   TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
//   DateTime _date = DateTime.now();
//   TextEditingController _dateController = TextEditingController();
//   TextEditingController _dateController2 = TextEditingController();
//   final DateFormat _dateFormatter = DateFormat('EEEEE', 'en_US');
//   final DateFormat _dateFormatter2 = DateFormat('MMMM dd, yyyy');
//   final List<String> _recurrences = ["Daily", "Weekly", "Monthly"];

//   @override
//   void initState() {
//     super.initState();

//     if (widget.sched != null) {
//       _title = widget.sched.title;
//       _recurrent = widget.sched.recur;
//       _recurrence = widget.sched.recurType;
//       _date = widget.sched.start;
//       _recurrenceEnd = widget.sched.end;
//     }
//   }

//   _handleDatePicker() async {
//     final DateTime date = await showDatePicker(
//       context: context,
//       initialDate: _date,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     if (date != null && date != _date) {
//       setState(() {
//         _date = date;
//       });
//       _dateController.text =
//           _dateFormatter.format(date) + ', ' + _dateFormatter2.format(date);
//     }
//     final DateTime date2 = await showDatePicker(
//       context: context,
//       initialDate: _recurrenceEnd,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     if (date2 != null && date2 != _recurrenceEnd) {
//       setState(() {
//         _recurrenceEnd = date2;
//       });
//       _dateController2.text =
//           _dateFormatter.format(date) + ', ' + _dateFormatter2.format(date);
//     }
//   }

//     void _selectTime() async {
//     final TimeOfDay newTime = await showTimePicker(
//       context: context,
//       initialTime: _time,
//     );
//     if (newTime != null) {
//       setState(() {
//         _time = newTime;
//       });
//     }
//   }

//   _submit() {
//     if (_formKey.currentState.validate()) {
//       _formKey.currentState.save();
//       print('$_title, $_date, $_recurrent, $_recurrence, $_recurrenceEnd');

//       Sched sched = Sched(
//         title: _title,
//         start: _date,
//         end: _recurrenceEnd,
//         recur: _recurrent,
//         recurType: _recurrence,
//       );
//       if (widget.sched == null){
//         sched.status = 0;
//         DatabaseHelper.instance.insertSched(sched); 
//       } 
//       else {
//         sched.status = widget.sched.status;
//         DatabaseHelper.instance.updateSched(sched);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
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
//                 SizedBox(height: 10.0),
//                 Form(
//                     key: _formKey,
//                     child: Column(children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: 20.0),
//                         child: TextFormField(
//                           style: TextStyle(fontSize: 18.0),
//                           decoration: InputDecoration(
//                               labelText: 'Subject Name',
//                               labelStyle: TextStyle(fontSize: 10.0),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               )),
//                           validator: (input) => input.trim().isEmpty
//                               ? 'Please enter the subject name'
//                               : null,
//                           onSaved: (input) => _title = input,
//                           initialValue: _title,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: 20.0),
//                         child: TextFormField(
//                           readOnly: true,
//                           controller: _dateController,
//                           style: TextStyle(fontSize: 18.0),
//                           onTap: _handleDatePicker,
//                           decoration: InputDecoration(
//                               labelText: 'Schedule start',
//                               labelStyle: TextStyle(fontSize: 10.0),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               )),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: 10.0),
//                         child: TextFormField(
//                           readOnly: true,
//                           controller: _dateController,
//                           style: TextStyle(fontSize: 18.0),
//                           onTap: _selectTime,
//                           decoration: InputDecoration(
//                               labelText: 'Select the time',
//                               labelStyle: TextStyle(fontSize: 10.0),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               )),
//                         ),
//                       ),
//                       Padding(
//                           padding: EdgeInsets.symmetric(vertical: 20.0),
//                           child: Row(children: <Widget>[
//                             Checkbox(
//                                 value: _recurrent,
//                                 onChanged: (bool value) {
//                                   setState(() {
//                                     _recurrent = value;
//                                   });
//                                 }),
//                             Text("Recurring schedule?")
//                           ])),
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: 20.0),
//                         child: DropdownButtonFormField(
//                           icon: Icon(Icons.arrow_drop_down_circle),
//                           iconSize: 22.0,
//                           iconEnabledColor: Theme.of(context).primaryColor,
//                           items: _recurrences.map((String recurrences) {
//                             return DropdownMenuItem(
//                                 value: recurrences,
//                                 child: Text(recurrences,
//                                     style: TextStyle(
//                                         color: Colors.black, fontSize: 18.0)));
//                           }).toList(),
//                           style: TextStyle(fontSize: 18.0),
//                           decoration: InputDecoration(
//                               labelText: 'Frequency',
//                               labelStyle: TextStyle(fontSize: 10.0),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               )),
//                           validator: (input) => _recurrent == null
//                               ? 'Please select the recurring frequency'
//                               : null,
//                           onSaved: (input) => _recurrence = input,
//                           onChanged: (value) {
//                             setState(() {
//                               _recurrence = value;
//                             });
//                           },
//                           value: _recurrence,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: 20.0),
//                         child: TextFormField(
//                           readOnly: true,
//                           controller: _dateController2,
//                           style: TextStyle(fontSize: 18.0),
//                           onTap: _handleDatePicker,
//                           decoration: InputDecoration(
//                               labelText: 'Schedule end',
//                               labelStyle: TextStyle(fontSize: 10.0),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               )),
//                         ),
//                       ),
//                       Container(
//                           margin: EdgeInsets.symmetric(vertical: 20.0),
//                           height: 60.0,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).primaryColor,
//                             borderRadius: BorderRadius.circular(30.0),
//                           ),
//                           child: TextButton(
//                             child: Text(
//                               'Add',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20.0,
//                               ),
//                             ),
//                             onPressed: _submit,
//                           ))
//                     ]))
//               ]),
//         ),
//       ),
//     ));
//   }
// }

// class _title {}
