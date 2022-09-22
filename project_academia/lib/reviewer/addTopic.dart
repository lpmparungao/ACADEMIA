import 'package:flutter/material.dart';
import 'package:sample1/reviewer/topicModel.dart';
import 'package:sample1/databaseHelpers.dart';

class AddTopicScreen extends StatefulWidget {
  final Function updateTopicList;
  final Topic topic;
  AddTopicScreen({this.updateTopicList, this.topic});

  @override
  _AddTopicScreenState createState() => _AddTopicScreenState();
}

class _AddTopicScreenState extends State<AddTopicScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';

  //enable this function if u want to initialize the current date
  @override
  void initState() { 
    super.initState();

    if (widget.topic != null){
      _title = widget.topic.titleTopic;
    }

  }
  @override
  void dispose(){
    //_dateController.dispose();
    super.dispose();
  }

  _delete() {
    DatabaseHelper.instance.deleteTopic(widget.topic.idTopic);
    widget.updateTopicList();
    Navigator.pop(context);
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('$_title'); //to check if working
      
      //insert the Topic to our user's database
      Topic topic = Topic(titleTopic: _title);
      if (widget.topic == null) {
        topic.statusTopic = 0;
        DatabaseHelper.instance.insertTopic(topic);
      }else {
        //update the Topic
        topic.idTopic = widget.topic.idTopic;
        topic.statusTopic = widget.topic.statusTopic;
        DatabaseHelper.instance.updateTopic(topic);
      }
      widget.updateTopicList();
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
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, 
                  size: 40,
                  color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                child: Text(
                  widget.topic == null ? 'Add Topic' : 'Update Topic', 
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
                ),
                ),
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
                            input.trim().isEmpty ? 'Please enter a Topic title' : null,
                          onSaved: (input) => _title = input,
                          initialValue: _title,
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
                            widget.topic == null ? 'Add' : 'Update', 
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(left: 40, right: 40),
                            primary: Color(0xFF98BD91),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          onPressed: _submit,
                        ),
                      ),
                      widget.topic != null ? Container(
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