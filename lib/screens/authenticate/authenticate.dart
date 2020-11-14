import 'package:flutter/material.dart';
import 'package:todo_list_f/screens/authenticate/register.dart';
import 'package:todo_list_f/screens/authenticate/signin.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn ?
    SignIn(toggleView: toggleView) : Register(toggleView: toggleView);
  }
}
