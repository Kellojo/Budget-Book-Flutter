import 'package:flutter/material.dart';

class InputField extends StatelessWidget {

  InputField({this.obscureText = false, this.hintText, this.text = null, this.onChanged});

  final String hintText;
  final String text;
  final bool obscureText;
  final Function onChanged;

  final style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      initialValue: text,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }
}