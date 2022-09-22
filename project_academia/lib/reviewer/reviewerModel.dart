class Reviewer {

  int idReviewer;
  String titleReviewer;
  String descriptionReviewer;
  int statusReviewer; // 0 - Reviewer incomplete, 1 - Reviewer complete

  Reviewer({this.titleReviewer, this.descriptionReviewer, this.statusReviewer});
  Reviewer.withId({this.idReviewer, this.titleReviewer, this.descriptionReviewer, this.statusReviewer});

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    if (idReviewer != null){
      map['idReviewer'] = idReviewer;
    }
    map['titleReviewer'] = titleReviewer;
    map['descriptionReviewer'] = descriptionReviewer;
    map['statusReviewer'] = statusReviewer;
    return map;
  }

  factory Reviewer.fromMap(Map<String, dynamic> map) {
    return Reviewer.withId(
      idReviewer: map['idReviewer'], 
      titleReviewer: map['titleReviewer'], 
      descriptionReviewer: map['descriptionReviewer'],
      statusReviewer: map['statusReviewer'],
      );
  }

}