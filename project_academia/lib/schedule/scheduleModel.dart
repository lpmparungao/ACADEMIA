// class ScheduleModel {

//   int idSched;
//   String titleSched;
//   DateTime dateSchedStart;
//   DateTime dateSchedEnd;
//   String prioritySched;
//   String repeatSched;
//   int statusSched; // 0 - task incomplete, 1 - task complete

//   ScheduleModel({this.titleSched, this.dateSchedStart, this.dateSchedEnd, this.prioritySched, this.repeatSched, this.statusSched});
//   ScheduleModel.withId({this.idSched, this.titleSched, this.dateSchedStart, this.dateSchedEnd, this.prioritySched, this.repeatSched, this.statusSched});

//   Map<String, dynamic> toMap(){
//     final map = Map<String, dynamic>();
//     if (idSched != null){
//       map['idSched'] = idSched;
//     }
//     map['titleSched'] = titleSched;
//     map['dateSchedEnd'] = dateSchedEnd.toIso8601String();
//     map['dateSchedStart'] = dateSchedStart.toIso8601String();
//     map['prioritySched'] = prioritySched;
//     map['repeatSched'] = repeatSched;
//     map['statusSched'] = statusSched;
//     return map;
//   }

//   factory ScheduleModel.fromMap(Map<String, dynamic> map) {
//     return ScheduleModel.withId(
//       idSched: map['idSched'], 
//       titleSched: map['titleSched'], 
//       dateSchedStart: DateTime.parse(map['dateSchedStart']),
//       dateSchedEnd: DateTime.parse(map['dateSchedEnd']),
//       prioritySched: map['prioritySched'],
//       repeatSched: map['repeatSched'],
//       statusSched: map['statusSched'],
//       );
//   }

// }