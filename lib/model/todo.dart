

class Todo {

  final String id;
  final String user;
  final String name;
  final String priority;
  final bool isDone;

  Todo({ this.id, this.user,  this.name, this.priority, this.isDone });


  String getId() {
    return id;
  }
}