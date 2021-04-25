import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sal_patient_client/common/sal_colors.dart';
import 'package:sal_patient_client/providers/filters_provider.dart';
import 'package:sal_patient_client/ui/practitioners_list_view.dart';

class PractitionersSearchResultsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PractitionersWidgetState();
}

class PractitionersWidgetState extends State<PractitionersSearchResultsWidget> {
  final double filterWidgetHeight = 60;
  final double ySpacing = 8.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<FiltersProvider>(builder: (context, provider, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: SalColors.black,
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            bottomOpacity: 0.0,
            title: Text("Search Results", style: SalStyles.titleTextStyle),
          ),
          body: SafeArea(
              child: Column(children: [
            Container(
              margin: EdgeInsets.all(ySpacing),
              // height: this.filterWidgetHeight,
              child: filterList(provider),
            ),
            SizedBox(height: ySpacing),
            Expanded(child: PractitionersListWidget()),
          ])));
    });
  }

  Widget filterList(FiltersProvider provider) {
    List<Widget> childrens = [];
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
          style: SalStyles.smallWhiteTextStyle,
        ),
        backgroundColor: SalColors.blue,
        elevation: 6.0,
        deleteIcon: Image.asset("assets/images/cancel.png",
            width: 16, height: 16, color: Colors.white),
        onDeleted: () {
          provider.delete(label);
        },
        padding: EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8));
  }
}
