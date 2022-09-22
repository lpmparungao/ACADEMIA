
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sample1/Home/HomePage.dart';
import 'package:sample1/reviewer/addReviewer.dart';
import 'package:sample1/reviewer/reviewerModel.dart';
import 'package:sample1/databaseHelpers.dart';

class ReviewerScreen extends StatefulWidget {
  final Function updateReviewerList;
  final Reviewer reviewer;
  ReviewerScreen({this.updateReviewerList, this.reviewer});

  @override
  _ReviewerScreenState createState() => _ReviewerScreenState();
}

class _ReviewerScreenState extends State<ReviewerScreen> {
  Future<List<Reviewer>> _reviewerList;
  bool selected = true;

  @override
  void initState() { 
    super.initState();
    _updateReviewerList();
  }

  _updateReviewerList() {
    setState(() {
      _reviewerList = DatabaseHelper.instance.getReviewerList();
    });
  }

  @override
  void dispose(){
    //_dateController.dispose();
    super.dispose();
  }

  // _delete() {
  //   DatabaseHelper.instance.deleteReviewer(widget.reviewer.idReviewer);
  //   widget.updateReviewerList();
  //   Navigator.pop(context);
  // }

  Widget _buildReviewer (Reviewer reviewer){
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
                child: Text(reviewer.titleReviewer,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    decoration: reviewer.statusReviewer == 0 
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
                  ),
                ),
              ),
              subtitle: Transform.translate(
                offset: Offset(20, 0),
                child: Text('${reviewer.descriptionReviewer}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    // decoration: reviewer.statusReviewer == 0 
                    // ? TextDecoration.none
                    // : TextDecoration.lineThrough,
                  ),
                ),
              ),
              trailing: IconButton(
              icon: Icon(selected ? Icons.bookmark_border_outlined : Icons.bookmark_added_rounded,
                  size: 25,
                  color: Color(0xFFE28C7E)),
                  onPressed: () {
                setState(() {
                  selected = !selected;
                });}
            ),),
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
                  builder: (_) => AddReviewerScreen(
                    updateReviewerList: _updateReviewerList,
                    reviewer: reviewer,
                  ),
                ),
              ),
          ),
        ],
        
        // secondaryActions: <Widget>[
        //   IconSlideAction(
        //     caption: 'Delete',
        //     color: Colors.red,
        //     icon: Icons.delete,
        //     onTap: () {
        //       AddReviewerScreen();
        //       _delete();
        //     },
        //     ),
        // ],
      ),
    );
  }

  navigateToFlashcard() async {
    Navigator.pushReplacementNamed(context, "Flashcard");//Flashcard
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // SizedBox(height: 30),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          HomePage(),
                    ),
                  ),
                  child: Icon(Icons.arrow_back, 
                  //size: 40,
                  color: Colors.black,
                  ),
                ),
                SizedBox(width: 20,),
              Text(
              'Reviewer',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.add, 
                  size: 20,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (_)=> AddReviewerScreen(
                        updateReviewerList: _updateReviewerList,
                      ),
                    ),
                  );
                },
              ),
              GestureDetector(
                child: Text(
                  'Add Card',
                  style: TextStyle(
                      color: Colors.black, 
                      fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (_)=> AddReviewerScreen(
                        updateReviewerList: _updateReviewerList,
                      ),
                    ),
                  );
                },
              ),
            ],
           )
           //backgroundColor: Color.fromRGBO(232, 232, 242, 1),
        ),
      ),
      body: FutureBuilder(
        future: _reviewerList,
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),

            );
          }

          if (snapshot.data.length == 0){
            return Container(
              color: Colors.white,
              child: Center(
                  child: Text('Click on the add card to add a flashcard!',
                      style: Theme.of(context).textTheme.bodyText2),
                ),
            );
          }

          // final int completedReviewerCount = snapshot.data
          // .where((Reviewer reviewer) => reviewer.statusReviewer == 1)
          // .toList()
          // .length;

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
                            IconButton(
                              icon: Icon(Icons.sort_outlined, 
                              size: 30,
                              color: Colors.black,
                              ),
                              onPressed: (){
                                return showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("Premium Account Only",textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.red[700], fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    content: Text("This feature is available for premium users only, get yours now!"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Okay',style: TextStyle(color: Colors.red[700]),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Spacer(),
                            ElevatedButton.icon(
                              icon: Icon(
                                Icons.library_books_outlined,
                                color: Colors.white,
                                size: 24.0,
                              ),
                              onPressed: navigateToFlashcard,
                              label: Text('Practice',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 8),
                                  primary: Color(0xFFE28C7E),
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.search, 
                              size: 30,
                              color: Colors.black,
                              ),
                              onPressed: () {
                                return showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text("Premium Account Only",textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.red[700], fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      content: Text("This feature is available for premium users only, get yours now!"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Okay',style: TextStyle(color: Colors.red[700]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                              },
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 10),
                    Center( 
                      //child: Text('$completedReviewerCount of ${snapshot.data.length}',
                      child: Text('Items: ${snapshot.data.length}',
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
            // return Container(
            //   margin: EdgeInsets.all(3),
            //   height: 100, 
            //   width: double.infinity, 
            //   color: Colors.red,
            // );
            return _buildReviewer(snapshot.data[index-1]);
          },
        );
        },
      ),
    );
  }
}