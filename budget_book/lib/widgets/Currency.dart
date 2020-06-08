

import 'dart:ui';

import 'package:flutter/material.dart';


class Currency extends StatelessWidget {

  final double amount;
  final String currencySymbol;
  final bool isExpense;

  Currency({this.amount = 0, this.currencySymbol = "€", this.isExpense = true});

  @override
  Widget build(BuildContext context) {
    Color color = isExpense ? Colors.red : Colors.green;
    return Row(children: <Widget>[
      Text((isExpense ? "-" : "+") + amount.toString(), style: TextStyle(color: color)),
      Text(" " + currencySymbol, style: TextStyle(color: color)),
    ]);
  }
}


