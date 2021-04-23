import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_patient_client/common/sal_colors.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandableText({Key key, this.maxLines, this.text}) : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Text(
          widget.text,
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: SalColors.grey)),
          overflow: TextOverflow.ellipsis,
          maxLines: _isExpanded ? null : widget.maxLines,
        ),
      );
}
