class Note {

  int idNote;
  String titleNote;
  String dateNote;
  int priorityNote;
  String descriptionNote;
  int colorNote; // 0 - task incomplete, 1 - task complete

 Note(this.titleNote, this.dateNote, this.priorityNote, this.colorNote,
      [this.descriptionNote]);

  Note.withId(this.idNote, this.titleNote, this.dateNote, this.priorityNote, this.colorNote,
      [this.descriptionNote]);


  int get id => idNote;

  String get title => titleNote;

  String get description => descriptionNote;

  int get priority => priorityNote;
  int get color => colorNote;
  String get date => dateNote;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this.titleNote = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this.descriptionNote = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 3) {
      this.priorityNote = newPriority;
    }
  }

  set color(int newColor) {
    if (newColor >= 0 && newColor <= 9) {
      this.colorNote = newColor;
    }
  }

  set date(String newDate) {
    this.dateNote = newDate;
  }


  Map<String, dynamic> toMap(){
    final map = Map<String, dynamic>();
    if (idNote != null){
      map['idNote'] = idNote;
    }
    map['titleNote'] = titleNote;
    map['dateNote'] = dateNote;
    map['priorityNote'] = priorityNote;
    map['descriptionNote'] = descriptionNote;
    map['colorNote'] = colorNote;
    return map;
  }

    Note.fromMapObject(Map<String, dynamic> map) {
    this.idNote = map['idNote'];
    this.titleNote = map['titleNote'];
    this.descriptionNote = map['descriptionNote'];
    this.priorityNote = map['priorityNote'];
    this.colorNote = map['colorNote'];
    this.dateNote = map['dateNote'];
  }

}