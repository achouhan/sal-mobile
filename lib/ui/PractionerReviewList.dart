import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_patient_client/common/sal_colors.dart';
import 'package:sal_patient_client/models/Review.dart';

class PractionerReviewList extends StatelessWidget {
  // Constants
  final xPaddding = 16.0;
  final yPaddding = 4.0;

  final List<Review> reviews;
  // Constructor
  const PractionerReviewList({Key key, this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: reviews.length,
        itemBuilder: (context, idx) {
          Review review = reviews[idx];
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: this.yPaddding, horizontal: this.xPaddding),
            child: _buildCard(review),
          );
        });
  }

  _buildCard(Review review) {
    return Card(
        elevation: 0.0,
        child: Container(
          height: 157,
          padding: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: new BoxDecoration(
                  color: SalColors.lightBlue,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 16),
              _buildRatingSection(review)
            ],
          ),
        ));
  }

  Expanded _buildRatingSection(Review review) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${review.reviewer}',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: SalColors.steelGrey))),
                  SizedBox(width: 8),
                  Container(
                    height: 16,
                    child: ListView.builder(
                        padding: EdgeInsets.only(left: 0),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: review.rating.ceil(),
                        itemBuilder: (context, idx) {
                          return Image.asset(
                            "assets/images/rating.png",
                            width: 16,
                            height: 16,
                            fit: BoxFit.fill,
                          );
                        }),
                  ),
                ],
              ),
              Spacer(),
              // SizedBox(width: 40),
              Text('${review.timeStamp}',
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: SalColors.grey))),
            ],
          ),
          SizedBox(width: 8),
          _buildTextSection(review),
        ],
      ),
    );
  }

  Container _buildTextSection(Review review) {
    return Container(
      width: 274,
      child: Text('${review.text}',
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: SalColors.grey))),
    );
  }
}
