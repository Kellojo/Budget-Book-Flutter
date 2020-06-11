
import 'package:flutter/material.dart';

class AnimatedToggleAbleWidget extends StatelessWidget {

  AnimatedToggleAbleWidget({this.child, this.showChild, this.vsync});

  final Widget child;
  final bool showChild;
  @required final TickerProvider vsync;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      curve: Curves.easeOut,
      opacity: showChild ? 1 : 0,
      duration: Duration(milliseconds: 250),
      child:  AnimatedSize(
        vsync: vsync,
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 200),
        child: showChild ? child : SizedBox(height: 0,)
      ),
    );
  }
}