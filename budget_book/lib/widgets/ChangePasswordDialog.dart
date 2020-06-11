

 
import 'package:budget_book/Config.dart';
import 'package:budget_book/widgets/VerticalSpacer.dart';
import 'package:flutter/material.dart';

Future<ChangePasswordResult> showChangePasswordDialog(BuildContext context) async {
  return showDialog<ChangePasswordResult>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return ChangePasswordDialog();
    },
  );
}

class ChangePasswordResult {
  ChangePasswordResult({this.oldPassword, this.newPassword});

  String oldPassword = "";
  String newPassword = "";
}


class ChangePasswordDialog extends StatefulWidget {
  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}


class _ChangePasswordDialogState extends State<ChangePasswordDialog> {

  final _formKey = GlobalKey<FormState>();
  String newPassword = "";
  String newPassword1 = "";
  String oldPassword = "";


  onChangePassword() {
    if (_formKey.currentState.validate()) {
      Navigator.of(context).pop(ChangePasswordResult(
        oldPassword: oldPassword,
        newPassword: newPassword
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Change Password"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
          children: <Widget>[
            Text("Please enter your new password below"),
            VerticalSpacer(),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Old password", hintText: "Old password",),
              onChanged: (value) {
                setState(() => {oldPassword = value});
              },
              validator: (value) {
                if (value.isEmpty || value.length < Config.MIN_PASSWORD_LENGTH) {
                  return 'Please enter password with at least 6 characters.';
                }
                return null;
              },
            ),
            VerticalSpacer(),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: "New Password", hintText: "New Password",),
              onChanged: (value) {
                setState(() => {newPassword = value});
              },
              validator: (value) {
                if (value.isEmpty || value.length < Config.MIN_PASSWORD_LENGTH) {
                  return 'Please enter password with at least 6 characters.';
                }
                return null;
              },
            ),
            VerticalSpacer(),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Repeat new password", hintText: "Repeat new password",),
              onChanged: (value) {
                setState(() => {newPassword1 = value});
              },
              validator: (value) {
                if (value.isEmpty || value.length < Config.MIN_PASSWORD_LENGTH) {
                  return 'Please enter password with at least 6 characters.';
                } else if (newPassword != newPassword1) {
                  return "The passwords must match";
                }
                return null;
              },
            ),
          ], 
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop(null);
          },
        ),
        FlatButton(
          child: Text("Update password"),
          onPressed: onChangePassword,
        )
      ],
    );
  }
}