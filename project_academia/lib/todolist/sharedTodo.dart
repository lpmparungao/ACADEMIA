String textTodo;
String textCountPending;
String textCountFinished;

class TaskInfoPref{
  String countTodoPending;
  String countTodoFinished;
  String taskTodo;

  TaskInfoPref({this.countTodoPending, this.taskTodo, this.countTodoFinished });

  Map<String, dynamic> toJson(){
    return{
    'countTodoPending': countTodoPending,
    'countTodoFinished': countTodoFinished,
    'taskTodo': taskTodo,
    };
  }
  TaskInfoPref.fromJson(Map<String, dynamic> json)
    : countTodoPending = json['countTodoPending'],
    countTodoFinished = json['countTodoFinished'],
    taskTodo = json['taskTodo'];
}