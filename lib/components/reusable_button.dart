import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  Color color;
  String text;
  VoidCallback onClick;

  ReusableButton(this.color, this.text, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30),
        elevation: 5,
        child: MaterialButton(
          onPressed: onClick,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          minWidth: 200,
          height: 42,
        ),
      ),
    );
  }
}
