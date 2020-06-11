


import 'package:flutter/material.dart';

class PageContainer extends StatelessWidget {

  PageContainer({this.child, this.backgroundColor = Colors.white, this.padding = const EdgeInsets.all(36.0)});

  final Widget child;
  final Color backgroundColor;
  final EdgeInsets padding;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: double.infinity,
      child: SingleChildScrollView(
        padding: padding,
        child: this.child,
      ),
    );
  }
}