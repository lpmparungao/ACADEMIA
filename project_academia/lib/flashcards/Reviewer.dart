import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:sample1/flashcards/flashcard.dart';
import 'package:sample1/flashcards/flashcard_view.dart';

class Reviewer extends StatefulWidget {
  @override
  _ReviewerState createState() => _ReviewerState();
}
class _ReviewerState extends State<Reviewer> {
  List<Flashcard> _flashcards = [
    Flashcard(
      question: "ano kinain mo?",
      answer: "secret"),
    Flashcard(
      question: "sino crush mo?",
      answer: "pake mo"),
    Flashcard(
      question: "ano binili mo?",
      answer: "hatdog ka"),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: Navbar(),
      //appBar: AppBar(title: Text('My Flashcards'),),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 70),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 30, width: 20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, 
                  size: 25,
                  color: Colors.black,
                  ),
                ),
                SizedBox(height: 30, width: 65,),
                Container(  
                  alignment: Alignment.center,
                  child: Text(
                    "My Flashcards",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE28C7E),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ]
            ),
            SizedBox(height: 10),
            Container(  
                  alignment: Alignment.center,
                  child: Text(
                    "Topic Title",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,),
                    textAlign: TextAlign.center,
                  ),
                ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.all(20),
              width: 350,
              height: 500,
              child: FlipCard(
                front: FlashcardView(
                  text: _flashcards[_currentIndex].question,
                  ),
                back: FlashcardView(
                  text: _flashcards[_currentIndex].answer,
                  ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: showPreviousCard,
                  icon: Icon(
                    Icons.chevron_left,
                  ),
                  label: Text('Prev',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF98BD91),
                      onPrimary: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: showNextCard,
                  icon: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                  label: Text('Next',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF98BD91),
                      onPrimary: Colors.white,
                  ),
                ), 
              ],
            )
          ],
        ),
      ),
    );
  }

  void showNextCard(){
  setState((){
      _currentIndex = 
        (_currentIndex + 1 < _flashcards.length) ? _currentIndex + 1: 0;
    });
  }
    
  void showPreviousCard(){
    setState((){
      _currentIndex = 
        (_currentIndex - 1 >= 0) ? _currentIndex - 1: _flashcards.length - 1;
    });
  }
}


