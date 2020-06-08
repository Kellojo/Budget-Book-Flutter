import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final List<String> texts;
  final int selectedIndex;
  final Function onToggle;

  ToggleButton({this.texts, this.selectedIndex = 0, this.onToggle});

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  List isSelected = new List();



  @override
  Widget build(BuildContext context) {
    List<Text> _texts = [];
    for (var item in widget.texts) {
      _texts.add(Text(item));
    }

    return ToggleButtons(
      children: _texts,
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
            if (buttonIndex == index) {
              isSelected[buttonIndex] = true;
            } else {
              isSelected[buttonIndex] = false;
            }
          }

          widget.onToggle(index);
        });
      },
      isSelected: isSelected,
    );
  }
}