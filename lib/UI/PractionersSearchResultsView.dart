import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SAL_App/Utils/styles.dart';
import 'package:SAL_App/Providers/FiltersProvider.dart';
import 'package:SAL_App/UI/PractionersListView.dart';

class PractionersSearchResultsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PractionersViewState();
}

class PractionersViewState extends State<PractionersSearchResultsView> {
  final double filterViewHeight = 60;
  final double ySpacing = 8.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<FiltersProvider>(builder: (context, provider, child) {
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
            margin: EdgeInsets.all(ySpacing),
            // height: this.filterViewHeight,
            child: filterList(provider),
          ),
          SizedBox(height: ySpacing),
          Expanded(child: PractionersListView()),
        ])));
    });
  }

  Widget filterList(FiltersProvider provider) {
    List<Widget> childrens = List<Widget>();
    provider.allFilterDisplayLabels().forEach((element) {
      childrens.add(_buildPill(element, provider));
      childrens.add(SizedBox(width: 8));
    });

    return Wrap(
      children: childrens,
    );
  }

  Widget _buildPill(String label, FiltersProvider provider) {
    return Chip(
        labelPadding: EdgeInsets.only(left: 2, right: 8, top: 2, bottom: 2),
        label: Text(
          label,
          style: kSmallWhiteTextStyle,
        ),
        backgroundColor: kSalThemeColor,
        elevation: 6.0,
        deleteIcon: Image.asset("icons/cancel.png",
            width: 16, height: 16, color: Colors.white),
        onDeleted: () {
            provider.delete(label);
        },
        padding: EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8));
  }
}
