import 'package:budget_book/Config.dart';
import 'package:flutter/material.dart';

class BrandButton extends StatelessWidget {

  BrandButton({this.text, this.onPressed});

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
            gradient: Config.BrandGradient,
            borderRadius: BorderRadius.circular(30.0)
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 150.0, minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}