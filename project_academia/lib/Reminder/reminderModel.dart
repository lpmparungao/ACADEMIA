// class Reminder {

//   int idreminder;
//   String titlereminder;
//   DateTime datereminder;
//   DateTime timereminder;
//   int statusreminder; // 0 - reminder incomplete, 1 - reminder complete

//   Reminder({this.titlereminder, this.datereminder, this.timereminder, this.statusreminder});
//   Reminder.withIdreminder({this.idreminder, this.titlereminder, this.datereminder, this.timereminder, this.statusreminder});

//   Map<String, dynamic> toMap(){
//     final map = Map<String, dynamic>();
//     if (idreminder != null){
//       map['idreminder'] = idreminder;
//     }
//     map['titlereminder'] = titlereminder;
//     map['datereminder'] = datereminder.toIso8601String();
//     map['timereminder'] = timereminder.toIso8601String();
//     map['statusreminder'] = statusreminder;
//     return map;
//   }

//   factory Reminder.fromMap(Map<String, dynamic> map) {
//     return Reminder.withIdreminder(
//       idreminder: map['idreminder'], 
//       titlereminder: map['titlereminder'], 
//       datereminder: DateTime.parse(map['datereminder']),
//       timereminder: DateTime.parse(map['timereminder']),
//       statusreminder: map['statusreminder'],
//       );
//   }

// }