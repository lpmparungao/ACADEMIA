// import 'package:flutter/material.dart';
// import 'package:sample1/schedule/scratchFolder%20(dont%20use)/AddEventScreen.dart';
// import 'package:sample1/schedule/scratchFolder%20(dont%20use)/schedModel.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';

// class Schedule extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Schedule'),
//           elevation: 0,
//           backgroundColor: Colors.white,
//         ),
//         body: SfCalendar(
//           view: CalendarView.week,
//           dataSource: MeetingDataSource(getAppointments()),
//         ),
//         floatingActionButton: FloatingActionButton(
//             child: Icon(Icons.add, color: Colors.white),
//             backgroundColor: Colors.red,
//             onPressed: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => AddEventScreen(),
//                   ),
//                 )));
//   }
// }


// List<Appointment> getAppointments() {
//   List<Appointment> meetings = <Appointment>[];
//   final DateTime today = DateTime.now();
//   final DateTime startTime =
//       DateTime(today.year, today.month, today.day, 9, 0, 0);
//   final DateTime endTime = startTime.add(const Duration(hours: 2));

//   meetings.add(Appointment(
//       startTime: startTime,
//       endTime: endTime,
//       subject: 'Conference',
//       color: Color(0xFFE28C7E),
//       recurrenceRule: 'FREQ=DAILY;COUNT=10',
//       isAllDay: true));

//   return meetings;
// }

// class MeetingDataSource extends CalendarDataSource {
  
//   MeetingDataSource(List<Appointment> source) {
//     appointments = source;
//   }
// }
