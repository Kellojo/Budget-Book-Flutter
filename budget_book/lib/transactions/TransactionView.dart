
import 'package:budget_book/Config.dart';
import 'package:budget_book/models/Transaction.dart';
import 'package:budget_book/service/AuthService.dart';
import 'package:budget_book/service/TransactionsService.dart';
import 'package:budget_book/widgets/DatePicker.dart';
import 'package:budget_book/widgets/HalfVerticalSpacer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytextformfield/moneytextformfield.dart';


class TransactionView extends StatefulWidget {
  @override
  _TransactionViewState createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {

  final _formKey = GlobalKey<FormState>();
  final _moneyController = new TextEditingController();
  BPTransaction transaction = BPTransaction(
    amount: 0,
    title: "",
    category: "",
    type: Config.TRANSACTION_TYPE_EXPENSE,
    occurredOn: DateTime.now()
  );


  /// Called, when the transaction is updated/created
  onSaveTransaction(_context) async {
    if (_formKey.currentState.validate()) {

      String message = "";
      if (transaction.id != null) {
        await TransactionsService.updateTransaction(transaction);
        message = "Successfully created transaction";
      } else {
        await TransactionsService.createTransaction(transaction);
        message = "Successfully created transaction";
      }

      // snackbar
      final snackBar = SnackBar(content: Text(message, textAlign: TextAlign.center,), backgroundColor: Colors.green,); 
      Scaffold.of(_context).showSnackBar(snackBar);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final BPTransaction _transaction = ModalRoute.of(context).settings.arguments;
    String title = "Create Transaction";
    String saveActionText = "Create";
    if (_transaction != null) {
      saveActionText = "Save";
      title = "Edit Transaction";
      transaction = _transaction;
    }

    // set controls for sliding segmented control switch                
    Map<String, Widget> _transactionTypes = {};
    _transactionTypes[Config.TRANSACTION_TYPE_EXPENSE] = Container(width: (MediaQuery.of(context).size.width - 50)/ 2, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[ Padding (padding: EdgeInsets.only(left: 15, right: 15), child: Text("Expense", style: TextStyle(color: Colors.red)))]));
    _transactionTypes[Config.TRANSACTION_TYPE_INCOME] = Container(width: (MediaQuery.of(context).size.width - 50)/ 2, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[ Padding (padding: EdgeInsets.only(left: 15, right: 15), child: Text("Income", style: TextStyle(color: Colors.green)))]));

    return Scaffold(
      appBar: AppBar(
            title: Text(title),
            actions: <Widget>[
              Builder(
                builder: (context) => new FlatButton(
                  onPressed: () {onSaveTransaction(context);},
                  child: Text(
                    saveActionText,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      ),
                  )
                ),
              ),
            ],
          ),
      
      body: Form(
        key: _formKey,
        child:Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                CupertinoSlidingSegmentedControl(
                  children: _transactionTypes,
                  groupValue: transaction.type,
                  onValueChanged: (String newKey) {
                    setState(() {
                      transaction.type = newKey;
                    });
                  },
                ),
                HalfVerticalSpacer(),

                TextFormField(
                  initialValue: transaction.title,
                  decoration: InputDecoration(labelText: "Title", hintText: "Title",),
                  onChanged: (value) {
                    setState(() => {transaction.title = value});
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a title for the transaction';
                    }
                    return null;
                  },
                ),
                HalfVerticalSpacer(),
                
                MoneyTextFormField(
                  settings: MoneyTextFormFieldSettings(
                    controller: _moneyController,
                    validator: (String amount) {
                      if (double.parse(amount) <= 0) {
                        return 'Please enter an amount greater than zero';
                      }
                      return null;
                    },
                    onChanged: () => {
                      setState(() => {
                        transaction.amount = double.parse(_moneyController.text)
                      })
                    },
                    moneyFormatSettings: MoneyFormatSettings(
                      amount: transaction.amount,
                      currencySymbol: Config.DEFAULT_CURRENCY_SYMBOL,
                      decimalSeparator: ",",
                      thousandSeparator: ".",
                      fractionDigits: 2,
                    ),
                  ),
                ),

                TextFormField(
                  initialValue: transaction.category,
                  decoration: InputDecoration(labelText: "Category", hintText: "Category",),
                  onChanged: (value) {
                    setState(() {
                      transaction.category = value;
                    });
                  },
                ),
                HalfVerticalSpacer(),

                DatePicker(
                  selectedDate: transaction.occurredOn,
                  selectDate: (DateTime date) {
                    setState(() {
                      transaction.occurredOn = date;
                    });
                  },
                ),
                HalfVerticalSpacer(),

                Row(
                  children: <Widget>[
                    Text("Is transaction complete: "),
                    Spacer(flex: 1),
                    CupertinoSwitch(
                      value: transaction.isTransactionCompleted,
                      onChanged: (value) {
                        setState(() {
                          transaction.isTransactionCompleted = value;
                        });
                      },
                    ),
                  ],
                ),
                HalfVerticalSpacer(),
                
              ],
            )
          )
        )
      )
    );
  }
}