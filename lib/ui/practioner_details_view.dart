import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sal_patient_client/Utils/CustomBackgroundView.dart';
import 'package:sal_patient_client/Utils/rounded_button.dart';
import 'package:sal_patient_client/common/sal_colors.dart';
import 'package:sal_patient_client/models/practioner.dart';
import 'package:sal_patient_client/ui/PractionerReviewList.dart';

import 'PractionersOverview.dart';

class PractionerDetailsView extends StatefulWidget {
  final Practioner practioner;
  const PractionerDetailsView({Key key, this.practioner}) : super(key: key);

  @override
  _PractionerDetailsViewState createState() => _PractionerDetailsViewState();
}

class _PractionerDetailsViewState extends State<PractionerDetailsView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    this._tabController =
        TabController(length: 2, vsync: this, initialIndex: this._currentIndex);
    // Add tab listener
    this._tabController.addListener(() {
      setState(() {
        this._currentIndex = this._tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    this._tabController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: SalColors.blue,
          elevation: 0.0,
          bottomOpacity: 0.0,
          title: Text('${this.widget.practioner.typeToString()} Profile',
              style: SalStyles.whiteTitleStyle),
        ),
        bottomNavigationBar: BottomAppBar(child: _buildScheduleSection()),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _imageCard(context),
            Text('${this.widget.practioner.name}',
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: SalColors.blue))),
            _buildRatingView(),
            SizedBox(height: 8),
            Container(
              height: 44,
              child: TabBar(
                  unselectedLabelColor: SalColors.steelGrey,
                  labelColor: SalColors.blue,
                  indicatorWeight: 3,
                  controller: this._tabController,
                  labelStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  unselectedLabelStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  tabs: [
                    Tab(text: 'OVERVIEW'),
                    Tab(text: 'REVIEWS'),
                  ]),
            ),
            SizedBox(height: 8),
            Expanded(
                child: (this._currentIndex == 0)
                    ? PractionerOverview(practioner: this.widget.practioner)
                    : PractionerReviewList(
                        reviews: widget.practioner.reviews())),
          ],
        ));
  }

  Row _buildRatingView() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${this.widget.practioner.typeToString()}',
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: SalColors.steelGrey))),
        SizedBox(width: 8),
        Text('${this.widget.practioner.rating}',
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: SalColors.steelGrey))),
        Image.asset(
          "assets/images/rating.png",
          width: 18,
          height: 18,
          fit: BoxFit.fill,
        )
      ],
    );
  }

  Widget _imageCard(BuildContext context) {
    double _height = MediaQuery.of(context).size.height / 4;
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      width: _width,
      child: Stack(
        children: [
          Container(
              height: _height, width: _width, child: CustomBackgroundView()),
          Positioned(
              top: (_height - 100) / 2,
              left: (_width - 100) / 2,
              child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey)))
        ],
      ),
    );
  }

  Widget _buildScheduleSection() {
    return Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/rupee.png",
              width: 18,
              height: 18,
              fit: BoxFit.fill,
              color: SalColors.blue,
            ),
            Text('${this.widget.practioner.fee}',
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: SalColors.blue))),
            Text(' / session',
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: SalColors.steelGrey))),
            SizedBox(width: 8.0),
            Expanded(
              child: RoundedButton(
                title: 'SCHEDULE',
                onPressed: () {},
                color: SalColors.blue,
                textColor: Colors.white,
              ),
            )
          ],
        ));
  }
}
