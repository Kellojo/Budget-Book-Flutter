
import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {

  GradientIcon({this.icon, this.gradient});

  final Icon icon;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: icon
    );
  }
}