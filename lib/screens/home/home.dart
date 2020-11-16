import 'package:flutter/material.dart';
import 'package:todo_list_f/model/theuser.dart';
import 'package:todo_list_f/model/todo.dart';

import 'package:todo_list_f/screens/home/todo_list.dart';
import 'package:todo_list_f/service/auth.dart';
import 'package:todo_list_f/service/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<TheUser>(context);

    return StreamProvider<List<Todo>>.value(
      value: DatabaseService(uid: user.uid).todos,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Todo List'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('logout')),
            // FlatButton.icon(
            //     onPressed: () => _showSettingsPanel(),
            //     icon: Icon(Icons.settings),
            //     label: Text('settings'))
          ],
        ),
        body: TodoList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await DatabaseService(uid: user.uid).addUserData('1', 'new todo', false);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }


}
