import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sample1/databaseHelpers.dart';
import 'package:sample1/todolist/taskModel.dart';

class AddTaskScreen extends StatefulWidget {
  final Function updateTaskList;
  final Task task;
  AddTaskScreen({this.updateTaskList, this.task});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _priority = '';
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat("MMM dd, yyyy");
  final List<String> _priorities = ['Low', 'Medium', 'High'];

  //enable this function if u want to initialize the current date
  @override
  void initState() { 
    super.initState();

    if (widget.task != null){
      _title = widget.task.title;
      _date = widget.task.date;
      _description = widget.task.description;
      _priority = widget.task.priority;
    }

    _dateController.text = _dateFormatter.format(_date);
  }
  @override
  void dispose(){
    _dateController.dispose();
    super.dispose();
  }

  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
      context: context, 
      initialDate: _date, 
      firstDate: DateTime.now(), 
      lastDate: DateTime(2050),
    );
    if (date != null && date != _date){
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  _delete() {
    DatabaseHelper.instance.deleteTask(widget.task.id);
    widget.updateTaskList();
    Navigator.pop(context);
  }



  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('$_title, $_date, $_priority, $_description'); //to check if working
      
      //insert the task to our user's database
      Task task = Task(title: _title, date: _date, description: _description, priority: _priority);
      if (widget.task == null) {
        task.status = 0;
        DatabaseHelper.instance.insertTask(task);
      }else {
        //update the task
        task.id = widget.task.id;
        task.status = widget.task.status;
        DatabaseHelper.instance.updateTask(task);
      }
      widget.updateTaskList();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20, 
            vertical: 10,
          ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50),
                Row(
                  children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, 
                  //size: 40,
                  color: Colors.black,
                  ),
                ),
                SizedBox(width: 20),
                Center(
                child: Text(
                  widget.task == null ? 'Add Task' : 'Update task', 
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 25),
                ),
                ),],),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20, 
                          vertical: 10,
                        ),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (input) => 
                            input.trim().isEmpty ? 'Please enter a task title' : null,
                          onSaved: (input) => _title = input,
                          initialValue: _title,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20, 
                          vertical: 10,
                        ),
                        child: TextFormField(
                          readOnly: true,
                          controller: _dateController,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          onTap: _handleDatePicker,
                          decoration: InputDecoration(
                            labelText: 'Date',
                            labelStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20, 
                          vertical: 10,
                        ),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onSaved: (input) => _description = input,
                          initialValue: _description,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20, 
                          vertical: 10,
                        ),
                        child: DropdownButtonFormField(
                          //iconEnabledColor: Colors.black,
                          items: _priorities.map((String priority){
                            return DropdownMenuItem(
                              value: priority,
                              child: Text(
                                priority, 
                                style: TextStyle(
                                  color: Colors.black, 
                                  fontSize: 18,
                                ),
                              ),
                            );
                          }).toList(),
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'Priority',
                            labelStyle: TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (input) => _priority == null 
                            ? 'Please select a priority level'
                            : null,
                          onChanged: (value){
                            setState(() {
                              _priority = value;
                            });
                          },
                          //value: _priority, //idk whats the error pa pero its in the vid num3
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF98BD91),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ElevatedButton(
                          child: Text(
                            widget.task == null ? 'Add' : 'Update', 
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(left: 40, right: 40),
                            primary: Color(0xFFE28C7E),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          onPressed: _submit,
                        ),
                      ),
                      widget.task != null ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 80),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ElevatedButton(
                          child: Text(
                            'Delete', 
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(left: 40, right: 40),
                            primary: Colors.red,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          onPressed: _delete,
                        ),
                      ) : SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}