import 'package:budget_book/Loading.dart';
import 'package:budget_book/authentication/SignIn.dart';
import 'package:budget_book/authentication/SignUp.dart';
import 'package:budget_book/service/AuthService.dart';
import 'package:budget_book/transactions/TransactionView.dart';
import 'package:budget_book/transactions/TransactionsList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:budget_book/models/User.dart';


void main() {
  runApp(BudgetP());
}

class BudgetP extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child:  MaterialApp(
        title: 'Budget Planner',
          theme: ThemeData(
            primarySwatch: MaterialColor(0xff514a9d, {
              50:Color(0xff005575),
              100:Color(0xff005575),
              200:Color(0xff005575),
              300:Color(0xff005575),
              400:Color(0xff005575),
              500:Color(0xff005575),
              600:Color(0xff005575),
              700:Color(0xff005575),
              800:Color(0xff005575),
              900:Color(0xff005575),
            }),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routes: {
            "/": (context) => Loading(),
            "/signIn": (context) => SignIn(),
            "/signUp": (context) => SignUp(),
            "/transactions": (context) => TransactionsList(),
            "/transactions/transaction": (context) => TransactionView(),
          },
          initialRoute: "/"
      ),
    );
  }

}