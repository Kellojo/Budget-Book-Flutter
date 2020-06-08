
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  ErrorMessage({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: TextAlign.center, style: TextStyle(color: Colors.red),);
  }
}