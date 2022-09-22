
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sample1/reviewer/addTopic.dart';
import 'package:sample1/reviewer/topicModel.dart';
import 'package:sample1/databaseHelpers.dart';
import 'package:flutter/cupertino.dart';

class TopicScreen extends StatefulWidget {
  final Function updateTopicList;
  final Topic topic;
  TopicScreen({this.updateTopicList, this.topic});

  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  Future<List<Topic>> _topicList;
    

  //enable this function if u want to initialize the current date
  @override
  void initState() { 
    super.initState();
    _updateTopicList();
    //_delete();


  }
  @override
  void dispose(){
    //_dateController.dispose();
    super.dispose();
  }

  // _delete() {
  //   DatabaseHelper.instance.deleteTopic(widget.topic.idTopic);
  //   widget.updateTopicList();
  //   Navigator.pop(context);
  // }

  // _submit() {
  //   if (_formKey.currentState.validate()) {
  //     _formKey.currentState.save();
  //     print('$_title'); //to check if working
      
  //     //insert the Topic to our user's database
  //     Topic topic = Topic(titleTopic: _title);
  //     if (widget.topic == null) {
  //       topic.statusTopic = 0;
  //       DatabaseHelper.instance.insertTopic(topic);
  //     }else {
  //       //update the Topic
  //       topic.idTopic = widget.topic.idTopic;
  //       topic.statusTopic = widget.topic.statusTopic;
  //       DatabaseHelper.instance.updateTopic(topic);
  //     }
  //     widget.updateTopicList();
  //     Navigator.pop(context);
  //   }
  // }

  _updateTopicList() {
    setState(() {
      _topicList = DatabaseHelper.instance.getTopicList();
    });
  }


  Widget _buildTopic (Topic topic){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        
        child: Column(
          children: <Widget>[
            // Icon(
            //       Icons.lightbulb_outline_rounded, 
            //       size: 20,
            //       color: Colors.black,
            //     ),
            ListTile(
              title: Transform.translate(
                offset: Offset(20, 0),
                child: Text(topic.titleTopic,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    decoration: topic.statusTopic == 0 
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
                  ),
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.favorite_border_outlined,
                  size: 25,
                  color: Color(0xFF98BD91),
                ),
                onPressed: () {},
              ),
              onTap: ()=> Navigator.of(context).pushNamed("Reviewer"),
              ),
            
            Divider(),
          ],
        ),
      ),
      
        actions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Colors.green,
            icon: Icons.edit,
            onTap: () => Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (_) => AddTopicScreen(
                    updateTopicList: _updateTopicList,
                    topic: topic,
                  ),
                ),
              ),
          ),
        ],
        
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {},
            ),
        ],
      ),
    );
  }

  navigateToAddTopic() async {
    Navigator.pushReplacementNamed(context, "AddTopicScreen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
              'Reviewer',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold, 
                  fontSize: 20),
              ),
              //SizedBox(width: 100),
              IconButton(
                icon: Icon(
                  Icons.archive_outlined, 
                  size: 25,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              // GestureDetector(
              //   child: Text(
              //     'Add Topic',
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold, 
              //         fontSize: 20),
              //   ),
              //   onTap: () {
              //     Navigator.push(
              //       context, 
              //       MaterialPageRoute(
              //         builder: (_)=> AddTopicScreen(
              //           updateTopicList: _updateTopicList,
              //         ),
              //       ),
              //     );
              //   },
              // ),
            ],
            
           )
           //backgroundColor: Color.fromRGBO(232, 232, 242, 1),
        ),
      ),
      body: FutureBuilder(
        future: _topicList,
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),
            );
          }

          final int completedTopicCount = snapshot.data
          .where((Topic topic) => topic.statusTopic == 1)
          .toList()
          .length;

          return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 0),
          itemCount: 1 + snapshot.data.length,
          itemBuilder: (BuildContext context, int index){
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15, 
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 0),
                      Container(
                        alignment: FractionalOffset.center,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){},
                              child: Icon(Icons.sort_outlined, 
                              size: 30,
                              color: Colors.black,
                              ),
                            ),
                            ElevatedButton.icon(
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              onPressed: () {Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (_)=> AddTopicScreen(
                                      updateTopicList: _updateTopicList,
                                    ),
                                  ),
                                );
                              },
                              label: Text('Add Topic',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 8),
                                  primary: Color(0xFF98BD91),
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Icon(Icons.search, 
                              size: 30,
                              color: Colors.black,
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    SizedBox(height: 10),
                    Center( 
                      child: Text('$completedTopicCount of ${snapshot.data.length}',
                      style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20, 
                      fontWeight: FontWeight.w600,  
                      ),
                    ),
                    ),
                  ]
                ),
              );
            }
            return _buildTopic(snapshot.data[index-1]);
          },
        );
        },
      ),
    );
  }

  
}