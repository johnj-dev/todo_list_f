class TheUser {

  String uid;

  TheUser({ this.uid });

}

class UserData {

  final String id;
  final String user;
  final String name;
  final String priority;
  final bool isDone;

  UserData({ this.user, this.id, this.priority, this.isDone, this.name });
}