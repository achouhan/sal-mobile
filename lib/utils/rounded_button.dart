import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color color;
  final Color textColor;
  final EdgeInsets margin;
  final bool enabled;
  final Color disabledColor;
  final Color disabledTextColor;

  const RoundedButton(
      {Key key,
      this.title,
      this.onPressed,
      this.color,
      this.textColor,
      this.margin = const EdgeInsets.symmetric(vertical: 10),
      this.enabled = true,
      this.disabledColor = const Color(0xFFE0EDF6),
      this.disabledTextColor = const Color(0xFF77849C)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      height: 44,
      child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: this.enabled ? this.color : this.disabledColor),
          onPressed: this.enabled ? onPressed : () {},
          child: Text(
            title.toUpperCase(),
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: this.enabled
                        ? this.textColor
                        : this.disabledTextColor)),
          )),
    );
  }
}
