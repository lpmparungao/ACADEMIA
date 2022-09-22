// class Sched {
//   int id;
//   DateTime start;
//   DateTime end;
//   String title;
//   String recurType;
//   bool recur;
//   int status;

//   Sched({this.start, this.end, this.title, this.recur, this.recurType, this.status});
//   Sched.withId(
//       {this.id, this.start, this.end, this.title, this.recur, this.recurType, this.status});

//   Map<String, dynamic> toMap() {
//     final map = Map<String, dynamic>();
//     if (id !=null){
//       map['id'] = id;
//     }
//     map['title'] = title;
//     map['start'] = start.toIso8601String();
//     map['end'] = end.toIso8601String();
//     map['recur'] = recur;
//     map['recurType'] = recurType;
//     map['status'] = status;
//     return map;
//   }

//   factory Sched.fromMap(Map<String, dynamic> map) {
//     return Sched.withId(
//         id: map['id'],
//         title: map['title'],
//         start: DateTime.parse(map['start']),
//         end: DateTime.parse(map['end']),
//         recur: map['recur'],
//         recurType: map['recurType'],
//         status: map['status']);
//   }
// }
