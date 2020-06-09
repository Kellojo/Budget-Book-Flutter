import 'package:budget_book/AppTitle.dart';
import 'package:budget_book/Config.dart';
import 'package:budget_book/authentication/AuthScreenArguments.dart';
import 'package:budget_book/service/AuthService.dart';
import 'package:budget_book/widgets/BrandButton.dart';
import 'package:budget_book/widgets/ErrorMessage.dart';
import 'package:budget_book/widgets/InputField.dart';
import 'package:budget_book/widgets/VerticalSpacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class SignUp extends StatefulWidget {
  SignUp({this.showSignInView});

  final Function showSignInView;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final AuthService _authService = AuthService();
  String email = "";
  String password = "";
  String errorMessage = "";

  onSignUpPress() async {
    try {
      if (await _authService.signUp(email, password) != null) {
        Navigator.pushNamedAndRemoveUntil(context, "/transactions", (route) {return false;});
      }
    } on PlatformException catch(e) {
      setState(() => errorMessage = e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthScreenArguments args = ModalRoute.of(context).settings.arguments;
    if (args != null) {
      email = args.email;
    }

    return Scaffold(
      appBar: GradientAppBar(
        gradient: Config.BrandGradientInverted,
      ),
      body: Center(
        child: Container(
          color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AppTitle(),
                  VerticalSpacer(),
                  Text(
                    "Welcome to the BudgetP mobile app. Create an account using your email and password.",
                    textAlign: TextAlign.center,
                  ),
                  VerticalSpacer(),
                  InputField(
                    onChanged: (val) {setState(() => email = val); },
                    hintText: "E-Mail",
                    text: args != null ? args.email : "",
                  ),
                  VerticalSpacer(),
                  InputField(
                    onChanged: (val) {setState(() => password = val); },
                    hintText: "Password",
                    obscureText: true,
                  ),
                  VerticalSpacer(),
                  ErrorMessage(text: errorMessage),
                  VerticalSpacer(),
                  BrandButton(text: "Sign Up", onPressed: onSignUpPress),
                  VerticalSpacer(),
                  FlatButton(onPressed: () {
                    Navigator.pop(context, email);
                  }, child: Text("Already have an account?"), textColor: Colors.blue)
                ],
              ),
            )
        )
      )
    );
  }
}