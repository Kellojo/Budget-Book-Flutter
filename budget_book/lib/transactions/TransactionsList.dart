import 'dart:ui';

import 'package:budget_book/Config.dart';
import 'package:budget_book/models/Transaction.dart';
import 'package:budget_book/service/AuthService.dart';
import 'package:budget_book/widgets/TransactionListItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  onCreateTransactionPress() {
    Navigator.pushNamed(context, "/transactions/transaction");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
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
                    gradient: LinearGradient(colors: [Color(0xff514a9d), Color(0xff005575)]),
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
                }
                return new ListView(
                  children: snapshot.data.documents.map((document) {
                    BPTransaction transaction = BPTransaction.fromMap(document);
                    return  TransactionListItem(
                      transaction: transaction,
                      onTap: onTapTransactionListItem,
                    );
                  }).toList(),
                );
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