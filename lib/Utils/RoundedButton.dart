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
      child: FlatButton(
          color: this.color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey)),
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(color: this.textColor),
          )),
    );
  }
}
