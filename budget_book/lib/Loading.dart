
import 'dart:async';

import 'package:budget_book/AppTitle.dart';
import 'package:budget_book/models/User.dart';
import 'package:budget_book/service/AuthService.dart';
import 'package:budget_book/widgets/VerticalSpacer.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {

  final AuthService _authService = new AuthService();
  StreamSubscription<User> _authStateSubscription;

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 500), () {
      _authStateSubscription = _authService.user.listen((user) {
        _authStateSubscription.cancel();
        if (user != null) {
          Navigator.pushReplacementNamed(context, "/transactions");
        } else {
          Navigator.pushReplacementNamed(context, "/signIn");
        }
      });
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppTitle(),
            VerticalSpacer(),
            VerticalSpacer(),
            VerticalSpacer(),
            CircularProgressIndicator(),
          ],
        )
        
      )
    );
  }
}