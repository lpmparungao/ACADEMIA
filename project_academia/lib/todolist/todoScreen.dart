import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sample1/Home/HomePage.dart';
import 'package:sample1/todolist/addTaskScreen.dart';
import 'package:sample1/databaseHelpers.dart';
import 'package:sample1/todolist/sharedTodo.dart';
import 'package:sample1/todolist/taskModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  Future<List<Task>> _taskList;
  final DateFormat _dateFormatter = DateFormat("MMM dd, yyyy");

  @override
  void initState() { 
    super.initState();
    _updateTaskList();
  }

  _updateTaskList() {
    setState(() {
      _taskList = DatabaseHelper.instance.getTaskList();
    });
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = prefs.getString('TestUser_Key');
    print("load info $json");

    if (json == null) {
      print('no data');
    } else {
      Map<String, dynamic> map = jsonDecode(json);
      print('map $map');

      final task = TaskInfoPref.fromJson(map);
      print('CountPending: ${task.countTodoPending}');
      print('CountFinished: ${task.countTodoFinished}');
      print('Task: ${task.taskTodo}');
    }
  }

  saveData() async {
    String textCountPending = '0';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final testUser = TaskInfoPref(
      countTodoPending: '$textCountPending',
      countTodoFinished: '$textCountFinished',
      taskTodo: '$textTodo',
    );

    String json = jsonEncode(testUser);
    print("save info $json");
    prefs.setString('TestUser_Key', json);
  }

  cleardata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    print("Data cleared");
  }

  Widget _buildTask (Task task){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              task.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                decoration: task.status == 0 
                ? TextDecoration.none
                : TextDecoration.lineThrough,
              ),
            ),
            subtitle: Text('${_dateFormatter.format(task.date)} ● ${task.priority}\n${task.description}',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  decoration: task.status == 0 
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            isThreeLine: true,
            trailing: Checkbox(
              checkColor: Colors.white,
              shape: CircleBorder(),
              onChanged: (value){
                task.status = value ? 1 : 0;
                DatabaseHelper.instance.updateTask(task);
                _updateTaskList();
              },
              activeColor: Color(0xFFEEBAB2),
              value: task.status == 1 ? true : false,
            ),
            onTap: ()=> Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (_) => AddTaskScreen(
                  updateTaskList: _updateTaskList,
                  task: task,
                ),
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: Navbar(),
      appBar: AppBar(centerTitle: true,
      automaticallyImplyLeading: false,
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back, 
                size: 23,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (_)=> HomePage(),
                  ),
                );
              },
            ),
            SizedBox(width: 20,),
            Text('Todo List'),
            
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),

      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Color(0xFFE28C7E),
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (_)=> AddTaskScreen(
              updateTaskList: _updateTaskList,
            ),
          ),
        ),
      ),
      body:FutureBuilder(
        future: _taskList,
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),
            );
          }

          final int completedTaskCount = snapshot.data
          .where((Task task) => task.status == 1)
          .toList()
          .length;
          textCountPending = '${snapshot.data.length - completedTaskCount}';
          textCountFinished = '$completedTaskCount';

          if (snapshot.data.length == 0){
            return Container(
              color: Colors.white,
              child: Center(
                  child: Text('Click on the add button to add a new task!',
                      style: Theme.of(context).textTheme.bodyText2),
                ),
            );
          }
          return ListView.builder(
            
          padding: EdgeInsets.symmetric(vertical: 0),
          itemCount: 1 + snapshot.data.length,
          itemBuilder: (BuildContext context, int index){
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40, 
                  //vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center( 
                      child: Text('$completedTaskCount of ${snapshot.data.length}',
                      style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20, 
                      fontWeight: FontWeight.w600,  
                      ),
                    ),
                    ),
                    SizedBox(height: 40),
                  ]
                ),
              );
            }
            return _buildTask(snapshot.data[index-1]);
          },
        );
        },
      ),
    );
  }
}