import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_patient_client/common/sal_colors.dart';
import 'package:sal_patient_client/models/practitioner.dart';

import '../utils/expandable_text.dart';

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
              width: 355,
              child:
                  ExpandableText(maxLines: 3, text: this.practitioner.aboutMe)),
          // Exp section
          SizedBox(height: 20),
          _buildInformationSection('Experience', this.practitioner.experience),

          // Speciality section
          SizedBox(height: 20),
          _buildInformationSection(
              'Speciality', this.practitioner.speciality.join(", ")),

          // Language section
          SizedBox(height: 20),
          _buildInformationSection(
              'Language', this.practitioner.languages.join(", ")),
        ]),
      ),
    );
  }

  Widget _buildInformationSection(String title, String subTitle) {
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
            Text(subTitle,
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: SalColors.steelGrey))),
          ],
        ),
      ],
    );
  }
}
