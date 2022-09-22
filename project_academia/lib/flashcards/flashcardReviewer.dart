import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:sample1/flashcards/flashcard_view.dart';
import 'package:sample1/reviewer/reviewerModel.dart';
import 'package:sample1/databaseHelpers.dart';
import 'package:sample1/reviewer/reviewerScreen.dart';

class Flashcard extends StatefulWidget {
  final Function updateReviewerList;
  final Reviewer reviewer;
  Flashcard({this.updateReviewerList, this.reviewer});

  @override
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  Future<List<Reviewer>> _reviewerList;

  @override
  void initState() {
    super.initState();
    _updateReviewerList();
    //_delete();
  }

  int _currentIndex = 0;

  _updateReviewerList() {
    setState(() {
      _reviewerList = DatabaseHelper.instance.getReviewerList();
    });
  }

  int itemCount;

  @override
  void dispose() {
    //_dateController.dispose();
    super.dispose();
  }

  Widget _buildReviewer(Reviewer reviewer) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(0),
                width: 350,
                height: 500,
                child: FlipCard(
                  front: FlashcardView(
                    text1: 'DESCRIPTION / QUESTION',
                    text: reviewer.descriptionReviewer,
                  ),
                  back: FlashcardView(
                    text1: 'ANSWER',
                    text: '${reviewer.titleReviewer}',
                  ),
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFE28C7E),
      body: FutureBuilder(
        future: _reviewerList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // final int completedReviewerCount = snapshot.data
          // .where((Reviewer reviewer) => reviewer.statusReviewer == 1)
          // .toList()
          // .length;
          // var rndItems  = snapshot.data.shuffle();
          //                                return ListView.separated(
          //                           separatorBuilder:
          //                               (BuildContext context, int index) {
          //                             return SizedBox(height: 3);
          //                           },
          //                           scrollDirection: Axis.horizontal,
          //                           shrinkWrap: true,
          //                           itemCount: rndItems ,
          //                           itemBuilder: (ctx, i) => (PdtItem(
          //                               title: snapshot.data[i].title,
          //                               imgUrl: snapshot.data[i].imgUrl,
          //                               price: snapshot.data[i].price,
          //                               pdt2: snapshot.data[i])),
          //                         );
          //var rndItems  = item.data.shuffle();
          //List<String> list = _reviewerList;
          //var item = snapshot.data.shuffle();
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 0),
            itemCount: 1 + snapshot.data.length,
            //scrollDirection: Axis.horizontal,
            //itemCount: item,
            //shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 60,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //SizedBox(width: 20),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ReviewerScreen(),
                                  ),
                                ),
                                child: Icon(
                                  Icons.arrow_back,
                                  //size: 15,
                                  color: Colors.black,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Flashcards",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: (){
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
                                child: Icon(
                                  Icons.repeat_rounded,
                                  //size: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                        // Center(
                        //   child: Text('$completedReviewerCount of ${snapshot.data.length}',
                        //   style: TextStyle(
                        //   color: Colors.grey,
                        //   fontSize: 20,
                        //   fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                        // ),
                        //SizedBox(height: 20),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // ElevatedButton.icon(
                            //   onPressed: (){
                            //     setState((){
                            //         _currentIndex =
                            //           (_currentIndex - 1 >= 0) ? _currentIndex - 1: snapshot.data.length - 1;
                            //       });
                            //   },
                            //   icon: Icon(
                            //     Icons.chevron_left,
                            //   ),
                            //   label: Text('Prev',
                            //     style: TextStyle(
                            //       fontSize: 15,
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            //   style: ElevatedButton.styleFrom(
                            //       primary: Color(0xFFE28C7E),
                            //       onPrimary: Colors.white,
                            //   ),
                            // ),
                            // ElevatedButton.icon(
                            //   onPressed: (){
                            //     setState((){
                            //       _currentIndex =
                            //         (_currentIndex + 1 < snapshot.data.length) ? _currentIndex + 1: 0;
                            //     });
                            //   },
                            //   icon: Icon(
                            //     Icons.chevron_right,
                            //     color: Colors.white,
                            //   ),
                            //   label: Text('Next',
                            //     style: TextStyle(
                            //       fontSize: 15,
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.white,
                            //     ),
                            //   ),

                            //   style: ElevatedButton.styleFrom(
                            //       primary: Color(0xFFE28C7E),
                            //       onPrimary: Colors.white,
                            //   ),
                            // ),
                          ],
                        )
                      ]),
                );
              }
              // void nextCard(){
              //   setState(() {
              //     _currentIndex = (_currentIndex + 1 < snapshot.data.length) ? _currentIndex + 1 : 0;
              //   });
              // }
              // void previousCard(){
              //   setState(() {
              //     _currentIndex = (_currentIndex - 1 >= 0) ? _currentIndex - 1 : snapshot.data.length - 1;
              //   });
              // }

              return _buildReviewer(snapshot.data[index-1]);
            },
            // itemBuilder: (ctx, i) => (Flashcard(
            //                             updateReviewerList: snapshot.data[i].descriptionReviewer,
            //                             reviewer: snapshot.data[i].titleReviewer,
            //                             )
            //                             ),
                                  
          );
        },
        
      ),
    );
  }

  

}
