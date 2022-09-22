// import 'dart:io';

// import 'package:path_provider/path_provider.dart';
// import 'package:sample1/schedule/scratchFolder%20(dont%20use)/schedModel.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._instance();
//   static Database _db;

//   DatabaseHelper._instance();

//   String schedTable = 'sched_table';
//   String colId = 'id';
//   String colTitle = 'title';
//   String colStart = 'start';
//   String colEnd = 'end';
//   String colRecurring = 'recurring';
//   String colStatus = 'status';

//   Future<Database> get db async {
//     if (_db == null) {
//       _db = await _initDb();
//     }
//     return _db;
//   }

//   Future<Database> _initDb() async {
//     Directory dir = await getApplicationDocumentsDirectory();
//     String path = dir.path + 'schedule.db';
//     final scheduleDb =
//         await openDatabase(path, version: 1, onCreate: _createDb);
//     return scheduleDb;
//   }

//   void _createDb(Database db, int version) async {
//     await db.execute(
//       'CREATE TABLE $schedTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colStart TEXT, $colEnd TEXT, $colRecurring TEXT, $colStatus INTEGER',
//     );
//   }

//   Future<List<Map<String, dynamic>>> getSchedMapList() async {
//     Database db = await this.db;
//     final List<Map<String, dynamic>> result = await db.query(schedTable);
//     return result;
//   }

//   Future<List<Sched>> getSchedList() async {
//     final List<Map<String, dynamic>> schedMapList = await getSchedMapList();
//     final List<Sched> schedList = [];
//     schedMapList.forEach((schedMap) {
//       schedList.add(Sched.fromMap(schedMap));
//     });
//     return schedList;
//   }

//   Future<int> insertSched(Sched sched) async {
//     Database db = await this.db;
//     final int result = await db.insert(schedTable, sched.toMap());
//     return result;
//   }

//   Future<int> updateSched(Sched sched) async {
//     Database db = await this.db;
//     final int result = await db.update(
//       schedTable,
//       sched.toMap(),
//       where: '$colId = ?',
//       whereArgs: [sched.id],
//     );
//     return result;

//   Future<int> deleteSched(int id) async {
//       Database db = await this.db;
//       final int result = await db.delete(
//         schedTable,
//         where: '$colId=7',
//         whereArgs: [id],
//       );
//       return result;
//     }
//   }
// }
