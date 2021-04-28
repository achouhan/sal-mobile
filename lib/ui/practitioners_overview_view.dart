import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_patient_client/common/sal_colors.dart';
import 'package:sal_patient_client/models/practitioner.dart';
import 'package:expandable_text/expandable_text.dart';

class PractitionerOverview extends StatelessWidget {
  final Practitioner practitioner;

  const PractitionerOverview({Key key, this.practitioner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('About',
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: SalColors.blue))),
          SizedBox(height: 8),
          Container(
              width: MediaQuery.of(context).size.width - 40,
              child: ExpandableText(this.practitioner.about,
                  expandText: 'more',
                  collapseText: 'less',
                  maxLines: 5,
                  linkColor: SalColors.blue)),
          // Exp section
          SizedBox(height: 20),
          _buildInformationSection(
              context, 'Experience', this.practitioner.experience),

          // Speciality section
          SizedBox(height: 20),
          _buildInformationSection(
              context, 'Speciality', this.practitioner.topics.join(", ")),

          // Language section
          SizedBox(height: 20),
          _buildInformationSection(
              context, 'Language', this.practitioner.languages.join(", ")),
        ]),
      ),
    );
  }

  Widget _buildInformationSection(
      BuildContext context, String title, String subTitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          "assets/images/minimize.png",
          width: 24,
          height: 24,
          fit: BoxFit.fill,
        ),
        SizedBox(width: 20.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: SalColors.blue))),
            SizedBox(height: 4.0),
            Container(
              width: MediaQuery.of(context).size.width - 84,
              child: Text(subTitle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: SalColors.steelGrey))),
            ),
          ],
        ),
      ],
    );
  }
}
