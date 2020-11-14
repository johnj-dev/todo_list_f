import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_f/model/todo.dart';
import 'package:todo_list_f/screens/home/todo_tile.dart';
import 'package:todo_list_f/shared/loading.dart';

class TodoList extends StatefulWidget {

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {

    final todos = Provider.of<List<Todo>>(context);

    return todos != null ?
      ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoTile(todo: todos[index]);
      },
    ) : Loading();


  }
}
