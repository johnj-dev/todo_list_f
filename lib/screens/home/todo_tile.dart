import 'package:flutter/material.dart';
import 'package:todo_list_f/model/todo.dart';
import 'package:todo_list_f/screens/home/settings_form.dart';
import 'package:todo_list_f/service/database.dart';
import 'package:todo_list_f/shared/constants.dart';

class TodoTile extends StatelessWidget {

  final Todo todo;
  TodoTile({ this.todo });

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(Todo todo) {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(todo: todo),
        );
      });
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          onTap: () async {
            await DatabaseService(uid: todo.user, id: todo.id).updateUserData(
                todo.priority,
                todo.name,
                !todo.isDone);
          },
          leading: CircleAvatar(
            radius: 18.0,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 15.0,
              backgroundColor: color(todo.priority),
            ),
          ),
          title: Text(todo.name),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check,
                color: todo.isDone ? Colors.green : Colors.red,
              ),
              IconButton(
                onPressed: () => _showSettingsPanel(todo),
                icon: Icon(Icons.settings),
              )
            ],
          ),
        ),
      ),
    );
  }
}
