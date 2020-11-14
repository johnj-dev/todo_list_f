import 'package:flutter/material.dart';
const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pink, width: 2.0)
  ),
);


Color color(String priority) {
  if (double.parse(priority) == 3.0) {
    return Colors.red;
  } else if (double.parse(priority) == 2.0) {
    return Colors.yellow;
  } else if (double.parse(priority) == 1.0) {
    return Colors.green;
  } else {
    return Colors.white;
  }
}