class Task {

  int id;
  String title;
  DateTime date;
  String priority;
  String description;
  int status; // 0 - task incomplete, 1 - task complete

  Task({this.title, this.date, this.priority, this.description, this.status});
  Task.withId({this.id, this.title, this.date, this.priority, this.description, this.status});

  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    if (id != null){
      map['id'] = id;
    }
    map['title'] = title;
    map['date'] = date.toIso8601String();
    map['priority'] = priority;
    map['description'] = description;
    map['status'] = status;
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
      id: map['id'], 
      title: map['title'], 
      date: DateTime.parse(map['date']),
      priority: map['priority'],
      description: map['description'],
      status: map['status'],
      );
  }

}