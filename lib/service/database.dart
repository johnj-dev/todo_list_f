import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_f/model/theuser.dart';
import 'package:todo_list_f/model/todo.dart';
import 'package:todo_list_f/screens/home/home.dart';

class DatabaseService {

  final String uid;
  final String id;

  DatabaseService({
    this.uid,
    this.id
  });

  // collection reference
  final CollectionReference todoCollection = FirebaseFirestore.instance.collection('todos');


  Future updateUserData(String priority, String name, bool isDone) async {
    return await todoCollection.doc(id).set({
      'user': uid,
      'priority': priority,
      'name': name,
      'isDone': isDone
    });
  }

  Future addUserData(String priority, String name, bool isDone) async {
    return await todoCollection.add({
      'user': uid,
      'priority': priority,
      'name': name,
      'isDone': isDone
    });
  }

  // todo_list from snapshot
  List<Todo> _todoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Todo(
        id: doc.id,
        user: doc.data()['user'] ?? '',
        name: doc.data()['name'] ?? '',
        priority: doc.data()['priority'] ?? '0',
        isDone: doc.data()['isDone'] ?? false,
      );
    }).where((todo) {
      return todo.user.compareTo(uid) == 0 ? true : false;
    }).toList();
  }

  // userData from snapShot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot.data()['user']);
    return UserData(
      user: uid,
      id: snapshot.data()['id'],
      name: snapshot.data()['name'],
      priority: snapshot.data()['priority'],
      isDone: snapshot.data()['isDone'],
    );
  }


  //get todos stream
  Stream<List<Todo>> get todos {
    return todoCollection.snapshots().map(_todoListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return todoCollection.doc(id).snapshots()
        .map(_userDataFromSnapshot);
  }
}