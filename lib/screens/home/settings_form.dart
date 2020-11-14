import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_f/model/theuser.dart';
import 'package:todo_list_f/model/todo.dart';
import 'package:todo_list_f/service/database.dart';
import 'package:todo_list_f/shared/constants.dart';
import 'package:todo_list_f/shared/loading.dart';

class SettingsForm extends StatefulWidget {


  final Todo todo;
  SettingsForm ({ this.todo });

  @override
  _SettingsFormState createState() => _SettingsFormState(todo: todo);
}

class _SettingsFormState extends State<SettingsForm> {

  final Todo todo;
  _SettingsFormState ({ this.todo });

  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentName;
  String _currentPriority;
  bool isDone;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<TheUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid, id: todo.id).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Update your task.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration.copyWith(hintText: 'Task'),
                  validator: (val) => val.isEmpty ? 'Please enter a task' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0),
                //dropdown
                // DropdownButtonFormField(
                //   decoration: textInputDecoration,
                //   value: _currentPriority ?? '3',
                //   onChanged: (val) => setState(() => _currentPriority = val),
                //   items: priorities.map((priority){
                //     return DropdownMenuItem(
                //       value: priority,
                //       child: Text('$priority'),
                //     );
                //   }).toList(),
                // ),
                // SizedBox(height: 20.0),
                //slider
                Slider(
                  value: double.parse(_currentPriority ?? userData.priority),
                  activeColor: color(_currentPriority ?? userData.priority),
                  min: 1,
                  max: 3,
                  divisions: 2,
                  onChanged: (val) => setState(() => _currentPriority = val.toString()),
                ),

                SizedBox(height: 20.0),
                RaisedButton(
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid, id: todo.id).updateUserData(
                          _currentPriority ?? userData.priority,
                          _currentName ?? userData.name,
                          todo.isDone
                      );
                      Navigator.pop(context);
                    }
                  },
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return Loading();
        }
      }
    );
  }
}
