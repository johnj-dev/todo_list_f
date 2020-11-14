import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_f/model/theuser.dart';
import 'package:todo_list_f/screens/authenticate/authenticate.dart';
import 'package:todo_list_f/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);

    return user != null ? Home() : Authenticate();
  }
}
