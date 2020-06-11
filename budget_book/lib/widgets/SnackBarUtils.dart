

import 'package:flutter/material.dart';

enum SnackBarType {ERROR, SUCCESS}

void showSnackBar(BuildContext context, SnackBarType type, String message) {
  Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            Icon(
              type == SnackBarType.SUCCESS ? Icons.check_circle : Icons.error,
              color: Colors.white,
            ),
            SizedBox(width: 10,),
            Text(message),
          ],
        ),
        backgroundColor: type == SnackBarType.SUCCESS ? Colors.green : Colors.red,
      )
    );
}