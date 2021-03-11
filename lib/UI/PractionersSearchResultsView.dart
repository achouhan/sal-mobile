import 'package:SAL_App/UI/PractionersListView.dart';
import 'package:flutter/material.dart';
import 'package:SAL_App/Utils/styles.dart';

class PractionersSearchResultsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PractionersViewState();
}

class PractionersViewState extends State<PractionersSearchResultsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          bottomOpacity: 0.0,
          title: Text("Search Results", style: kTitleTextStyle),
        ),
        body: SafeArea(
            child: Column(children: [
          Container(
            margin: EdgeInsets.all(8.0),
            height: 60,
            child: filterList(),
          ),
          SizedBox(height: 8),
          Expanded(child: PractionersListView()),
        ])));
  }

  // Returning mock data for now
  Widget filterList() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        _buildChip("Hello", kSalThemeColor),
        SizedBox(width: 8),
        _buildChip("Hello 1", kSalThemeColor),
        SizedBox(width: 8),
        _buildChip("Hello 2", kSalThemeColor),
        SizedBox(width: 8),
        _buildChip("Hello 3", kSalThemeColor),
        SizedBox(width: 8),
        _buildChip("Hello 4", kSalThemeColor),
        SizedBox(width: 8),
        _buildChip("Hello 5", kSalThemeColor),
      ],
    );
  }

  Widget _buildChip(String label, Color color) {
    return Chip(
        labelPadding: EdgeInsets.only(left: 2, right: 8, top: 2, bottom: 2),
        label: Text(
          label,
          style: kSmallWhiteTextStyle,
        ),
        backgroundColor: color,
        elevation: 6.0,
        deleteIcon: Image.asset("icons/cancel.png",
            width: 16, height: 16, color: Colors.white),
        onDeleted: () {
          print("On Delete");
        },
        padding: EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8));
  }
}
