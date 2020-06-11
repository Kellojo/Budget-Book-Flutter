
import 'package:budget_book/widgets/AnimatedToggleAbleWidget.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  ErrorMessage({this.text, this.vsync});

  final String text;
  @required final TickerProvider vsync;

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleAbleWidget(
      vsync: vsync,
      showChild: text != "",
      child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: Colors.red),),
    );
  }
}