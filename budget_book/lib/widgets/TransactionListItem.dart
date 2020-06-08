

import 'package:budget_book/models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../Config.dart';
import 'Currency.dart';

class TransactionListItem extends StatelessWidget {

  TransactionListItem({this.transaction, this.onTap});

  final BPTransaction transaction;
  final Function onTap;

  onTapListTile() {
    onTap(transaction);
  }

  @override
  Widget build(BuildContext context) {
    String subtitleText = timeago.format(transaction.occurredOn);
    if (transaction.category.trim() != "") {
      subtitleText += " - " + transaction.category;
    }

    return Card(
      elevation: 1,
      child: ListTile(
        title: new Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Text(transaction.title, overflow: TextOverflow.ellipsis,),
            ),
            Text(" ("),
            Currency(
              amount: transaction.amount,
              currencySymbol: Config.DEFAULT_CURRENCY_SYMBOL,
              isExpense: transaction.type == Config.TRANSACTION_TYPE_EXPENSE,
            ),
            Text(")"),
          ],
        ),
        subtitle: new Text(subtitleText),
        trailing: Icon(Icons.chevron_right),
        onTap: onTapListTile,
      )
    );
  }
}