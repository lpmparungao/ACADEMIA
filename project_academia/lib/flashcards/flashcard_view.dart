import 'package:flutter/material.dart';

class FlashcardView extends StatelessWidget {
  final String text;
  final String text1;

  FlashcardView ({Key key, this.text, this.text1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Color(0xFFEEBAB2),
      child: Center(
        child: Column(
          children: [
            Spacer(),
            Text(text1, textAlign: TextAlign.center,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Divider(),
            Spacer(),
            Text(text, textAlign: TextAlign.center,style: TextStyle(fontSize: 18, ),),
            Spacer(),
            Spacer(),
          ],
      ),),
    );
  }
}