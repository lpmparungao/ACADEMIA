var imagePath;
String textName;
String textEmail;
String textDescription;
String textLRN;
String textCourse;
String textNumber;
String textBirthdate;

class UserInfoPref{
  var imagePath;
  String userName;
  String userEmail;
  String userLRN;
  String userDescription;
  String userCourse;
  String userNumber;
  String userBirthdate;

  UserInfoPref({this.imagePath, 
  this.userName, 
  this.userEmail, 
  this.userLRN, 
  this.userDescription, 
  this.userCourse, 
  this.userNumber, 
  this.userBirthdate});

  Map<String, dynamic> toJson(){
    return{
    'imagePath': imagePath,
    'userName': userName,
    'userEmail': userEmail,
    'userLRN': userLRN,
    'userDescription': userDescription,
    'userCourse': userCourse,
    'userNumber': userNumber,
    'userBirthdate': userBirthdate,
    };
  }
  UserInfoPref.fromJson(Map<String, dynamic> json)
    : imagePath = json['imagePath'],
    userName = json['userName'],
    userEmail = json['userEmail'],
    userLRN = json['userLRN'],
    userDescription = json['userDescription'],
    userCourse = json['userCourse'],
    userBirthdate = json['userBirthdate'],
    userNumber = json['userNumber'];
}