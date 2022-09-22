class Topic {

  int idTopic;
  String titleTopic;
  int statusTopic; // 0 - Reviewer incomplete, 1 - Reviewer complete

  Topic({this.titleTopic, this.statusTopic});
  Topic.withId({this.idTopic, this.titleTopic, this.statusTopic});

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    if (idTopic != null){
      map['idTopic'] = idTopic;
    }
    map['titleTopic'] = titleTopic;
    map['statusTopic'] = statusTopic;
    return map;
  }

  factory Topic.fromMap(Map<String, dynamic> map) {
    return Topic.withId(
      idTopic: map['idTopic'], 
      titleTopic: map['titleTopic'], 
      statusTopic: map['statusTopic'],
      );
  }

}