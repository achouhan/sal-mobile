import 'package:flutter/material.dart';
import 'package:sal_patient_client/models/practioner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_patient_client/utils/styles.dart';

class PractionerCard extends StatelessWidget {
  final kSmallFontColor = Color(0xFF445066);

  final Practioner practioner;

  PractionerCard({Key key, this.practioner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Container(
        height: 124,
        child: Row(
          children: [
            Stack(children: [
              Container(
                height: 84,
                width: 84,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: 84,
                    height: 16,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16)),
                        color: Colors.black),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${this.practioner.rating}',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white))),
                          Image.asset(
                            "icons/rating.png",
                            width: 16,
                            height: 16,
                            fit: BoxFit.fill,
                          ),
                        ]),
                  ))
            ]),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  // Name
                  Text(practioner.name,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: kSalThemeColor))),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Text(practioner.typeToString(),
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: kSmallFontColor))),
                      SizedBox(width: 16),
                      Text('Rs ${practioner.fee}',
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: kSmallFontColor))),
                    ],
                  ),
                  SizedBox(height: 4),
                  // Exp
                  Text(practioner.experience,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: kSmallFontColor))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
