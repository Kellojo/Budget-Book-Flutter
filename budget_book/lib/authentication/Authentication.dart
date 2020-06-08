import 'package:flutter/material.dart';
import 'package:budget_book/authentication/SignIn.dart';
import 'package:budget_book/authentication/SignUp.dart';


class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  MaterialPageRoute signInRoute;

  void showSignInView() {
    Navigator.pop(context);
  }

  void showSignUpView() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUp(showSignInView: showSignInView)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SignIn(showSignUpView: showSignUpView);
  }
}