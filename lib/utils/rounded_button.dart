import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color color;
  final Color textColor;

  const RoundedButton(
      {Key key, this.title, this.onPressed, this.color, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 44,
      child: TextButton(
          style: TextButton.styleFrom(backgroundColor: this.color),
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(color: this.textColor),
          )),
    );
  }
}
