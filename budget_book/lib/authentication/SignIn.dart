import 'package:budget_book/AppTitle.dart';
import 'package:budget_book/Config.dart';
import 'package:budget_book/authentication/AuthScreenArguments.dart';
import 'package:budget_book/widgets/BrandButton.dart';
import 'package:budget_book/widgets/ErrorMessage.dart';
import 'package:budget_book/widgets/InputField.dart';
import 'package:budget_book/widgets/PageContainer.dart';
import 'package:budget_book/widgets/VerticalSpacer.dart';
import 'package:flutter/material.dart';
import 'package:budget_book/service/AuthService.dart';
import 'package:flutter/services.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';


class SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();
  String email = "";
  String password = "";
  String errorMessage = "";

  onSignInPress() async {
    try {
      if (await _authService.signIn(email, password) != null) {
        Navigator.pushNamedAndRemoveUntil(context, "/transactions", (route) {return false;});
      }
    } on PlatformException catch(e) {setState(() => errorMessage = e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        gradient: Config.BrandGradient,
      ),
      body: PageContainer (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppTitle(),
            VerticalSpacer(),
            Text(
              "Welcome to the BudgetP mobile app. Sign in using your e-mail and password.",
              textAlign: TextAlign.center,
            ),
            VerticalSpacer(),
            InputField(
              onChanged: (val) {setState(() => email = val); },
              hintText: "E-Mail",
              text: email,
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
            BrandButton(text: "Sign In", onPressed: onSignInPress),
            VerticalSpacer(),
            FlatButton(onPressed: () async {
              Navigator.pushNamed(context, "/signUp", arguments: AuthScreenArguments(email: this.email));
            }, child: Text("Don't have an account yet?"), textColor: Colors.blue)
          ],
        ),
      )
    );
  }
}

class SignIn extends StatefulWidget {
  SignIn({this.showSignUpView});

  final Function showSignUpView;

  @override
  SignInState createState() => SignInState();
}