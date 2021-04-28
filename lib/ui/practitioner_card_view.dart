import 'package:flutter/material.dart';
import 'package:sal_patient_client/common/sal_colors.dart';
import 'package:sal_patient_client/models/practitioner.dart';
import 'package:google_fonts/google_fonts.dart';

class PractitionerCard extends StatelessWidget {
  final Practitioner practitioner;

  PractitionerCard({Key key, this.practitioner}) : super(key: key);

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
                    //child: Image.network(this.practitioner.photoUrl),
                    color: SalColors.grey),
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
                          Text('${this.practitioner.averageRating}',
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white))),
                          Image.asset(
                            "assets/images/rating.png",
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
                  Text(practitioner.name,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: SalColors.blue))),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Text(practitioner.typeToString(),
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: SalColors.steelGrey))),
                      SizedBox(width: 16),
                      Text('Rs ${practitioner.price}',
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: SalColors.steelGrey))),
                    ],
                  ),
                  SizedBox(height: 4),
                  // Exp
                  Text(practitioner.experience,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: SalColors.steelGrey))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
