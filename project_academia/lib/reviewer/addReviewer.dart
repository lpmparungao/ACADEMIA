import 'package:flutter/material.dart';
import 'package:sample1/reviewer/reviewerModel.dart';
import 'package:sample1/databaseHelpers.dart';

class AddReviewerScreen extends StatefulWidget {
  final Function updateReviewerList;
  final Reviewer reviewer;
  AddReviewerScreen({this.updateReviewerList, this.reviewer});

  @override
  _AddReviewerScreenState createState() => _AddReviewerScreenState();
}

class _AddReviewerScreenState extends State<AddReviewerScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';

  //enable this function if u want to initialize the current date
  @override
  void initState() { 
    super.initState();

    if (widget.reviewer != null){
      _title = widget.reviewer.titleReviewer;
      _description = widget.reviewer.descriptionReviewer;
    }

  }
  @override
  void dispose(){
    //_dateController.dispose();
    super.dispose();
  }

  _delete() {
    DatabaseHelper.instance.deleteReviewer(widget.reviewer.idReviewer);
    widget.updateReviewerList();
    Navigator.pop(context);
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('$_title, $_description'); //to check if working
      
      //insert the reviewer to our user's database
      Reviewer reviewer = Reviewer(titleReviewer: _title, descriptionReviewer: _description);
      if (widget.reviewer == null) {
        reviewer.statusReviewer = 0;
        DatabaseHelper.instance.insertReviewer(reviewer);
      }else {
        //update the reviewer
        reviewer.idReviewer = widget.reviewer.idReviewer;
        reviewer.statusReviewer = widget.reviewer.statusReviewer;
        DatabaseHelper.instance.updateReviewer(reviewer);
      }
      widget.updateReviewerList();
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
                    SizedBox(height: 30),
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
                  widget.reviewer == null ? 'Add Reviewer' : 'Update Reviewer', 
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 25
                ),
                ),
                ),
                  ],
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
                            input.trim().isEmpty ? 'Please enter a Reviewer title' : null,
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
                      
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          //color: Color(0xFFE28C7E).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ElevatedButton(
                          child: Text(
                            widget.reviewer == null ? 'Add' : 'Update', 
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
                      widget.reviewer != null ? Container(
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
                              fontSize: 15,
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