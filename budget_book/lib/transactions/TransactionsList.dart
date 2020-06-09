import 'dart:ui';

import 'package:budget_book/Config.dart';
import 'package:budget_book/models/Transaction.dart';
import 'package:budget_book/service/AuthService.dart';
import 'package:budget_book/service/TransactionsService.dart';
import 'package:budget_book/widgets/GradientIcon.dart';
import 'package:budget_book/widgets/HalfVerticalSpacer.dart';
import 'package:budget_book/widgets/TransactionListItem.dart';
import 'package:budget_book/widgets/VerticalSpacer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';


class TransactionsList extends StatefulWidget {
  @override
  _TransactionsListState createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final AuthService _authService = AuthService();


  onTapTransactionListItem(BPTransaction transaction) {
    Navigator.pushNamed(context, "/transactions/transaction", arguments: transaction);
  }

  onDismissedTransactionListItem(BPTransaction transaction) async {
    await TransactionsService.deleteTransaction(transaction);
  }

  onCreateTransactionPress() {
    Navigator.pushNamed(context, "/transactions/transaction");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: GradientAppBar(
        gradient: Config.BrandGradient,
        title: Text("BudgetP"),
      ),
      drawer: new Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            FutureBuilder(
              future: AuthService.getUserEmail(),
              builder: (context, email) {
                return DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: Config.BrandGradient,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Welcome', style: TextStyle(color: Colors.white, fontSize: 25),),
                        Text(email.data, style: TextStyle(color: Colors.white, fontSize: 25),),
                      ],
                    ), 
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Get BudgetP desktop app'),
              leading: Icon(Icons.desktop_mac),
              onTap: () async {
                const url = Config.BUDGET_P_WEBSITE;
                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
            ),
            ListTile(
              title: Text('About'),
              leading: Icon(Icons.info_outline),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: Config.APP_NAME,
                  applicationVersion: Config.VERSION,
                  applicationLegalese: Config.APP_LEGALESE,
                  applicationIcon: Image(
                    image: AssetImage(Config.APP_ICON),
                    width: 48,
                    height: 48,
                  ),
                  useRootNavigator: true
                );
              },
            ),
            ListTile(
              title: Text('Reach out'),
              leading: Icon(Icons.mail_outline),
              onTap: () async {
                const url = "mailto:" + Config.SUPPORT_EMAIL;
                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
            ),
            ListTile(
              title: Text('Sign out'),
              leading: Icon(Icons.exit_to_app),
              onTap: () async {
                if (await _authService.signOut()) {
                  Navigator.pushNamedAndRemoveUntil(context, "/signIn", (route) {return false;});
                }
              },
            ),
          ],
        ),
      ),
      body: new Padding(
        padding: EdgeInsets.only(top: 12.5, left: 12.5, right: 12.5),
        child: new FutureBuilder(
          future: AuthService.getUserUID(),
          builder: (BuildContext context, AsyncSnapshot<String> userId) {
            return StreamBuilder(
              stream: Firestore.instance.collection('transactions').document(userId.data).collection("synchronizable").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.data.documents.length == 0) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        
                        GradientIcon(
                          gradient: Config.BrandGradient,
                          icon: Icon(
                            Icons.library_books,
                            color: Colors.white,
                            size: 64
                          ),
                        ),
                        HalfVerticalSpacer(),
                        Text(
                          "No Transactions Found",
                          style: TextStyle(color: Colors.grey[800], fontSize: 20),
                        ),
                        HalfVerticalSpacer(),
                        Text(
                          "You have no transactions to sync.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "Create one to get started",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                        VerticalSpacer(),
                        VerticalSpacer(),
                        VerticalSpacer(),
                        VerticalSpacer(),
                      ],
                    ),
                  );
                } else {
                  return new ListView(
                    children: snapshot.data.documents.map((document) {
                      BPTransaction transaction = BPTransaction.fromMap(document);
                      return TransactionListItem(
                        transaction: transaction,
                        onTap: onTapTransactionListItem,
                        onDismissed: onDismissedTransactionListItem,
                      );
                    }).toList(),
                  );
                }
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateTransactionPress,
        child: Icon(Icons.add, size: 30,),
      ),
    );
  }
}