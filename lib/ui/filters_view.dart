import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sal_patient_client/common/sal_colors.dart';
import 'package:sal_patient_client/providers/filters_provider.dart';
import 'package:sal_patient_client/models/practitioner.dart';
import 'package:sal_patient_client/ui/practitioners_search_results_view.dart';
import 'package:sal_patient_client/utils/rounded_button.dart';

class FiltersView extends StatefulWidget {
  @override
  _FiltersViewState createState() => _FiltersViewState();
}

class _FiltersViewState extends State<FiltersView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<FiltersProvider>(builder: (context, provider, child) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerRow(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: FiltersProvider.getAllPractitioners()
                  .map((type) => buildToggleButton(type, provider))
                  .toList(),
            ),
            SizedBox(height: 16),
            _topicSection(provider),
            SizedBox(height: 16),
            _advanceSection(provider),
            SizedBox(height: 16),
            _buttonSection()
          ],
        ),
      );
    });
  }

  Row _buttonSection() {
    return Row(children: [
      Expanded(
        child: RoundedButton(
          title: 'CLEAR',
          onPressed: () {
            Provider.of<FiltersProvider>(context, listen: false).deleteAll();
          },
          color: Colors.white,
          textColor: SalColors.grey,
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        child: RoundedButton(
          title: 'SEARCH',
          onPressed: () async {
            final value = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PractitionersSearchResultsView()));
            Provider.of<FiltersProvider>(context, listen: false).refresh();
          },
          color: SalColors.blue,
          textColor: Colors.white,
        ),
      )
    ]);
  }

  Container _topicSection(FiltersProvider provider) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Topic",
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: SalColors.blue)),
          ),
          SizedBox(height: 12),
          Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: SalColors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  isExpanded: true,
                  autofocus: false,
                  underline: Container(color: Colors.transparent),
                  hint: Text("Select Topic", style: fieldTextStyle()),
                  style: fieldTextStyle(),
                  value: provider.getTopic(),
                  icon: Icon(Icons.keyboard_arrow_down),
                  elevation: 8,
                  iconSize: 24,
                  items: Provider.of<FiltersProvider>(context, listen: false)
                      .getAllTopics()
                      .map((value) =>
                          DropdownMenuItem(child: Text(value), value: value))
                      .toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      provider.setTopic(newValue);
                    });
                  },
                ),
              ))
        ],
      ),
    );
  }

  Widget _headerRow() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Text(
          "Connect With",
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: SalColors.blue)),
        ),
      ),
      Image.asset(
        "assets/images/information.png",
        width: 24,
        height: 24,
      ),
      SizedBox(width: 8)
    ]);
  }

  GestureDetector buildToggleButton(
      PractitionerType type, FiltersProvider provider) {
    return GestureDetector(
      onTap: () {
        setState(() {
          provider.setType(type);
        });
      },
      child: Container(
        width: 156,
        height: 40,
        decoration: BoxDecoration(
            color:
                provider.types.contains(type) ? SalColors.blue : Colors.white,
            border: Border.all(color: SalColors.grey),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Center(
          child: Text(
              type == PractitionerType.counsellor ? "Counsellor" : "Listener",
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: provider.types.contains(type)
                          ? Colors.white
                          : SalColors.grey))),
        ),
      ),
    );
  }

  Widget _advanceSection(FiltersProvider provider) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
          title: Text("Advance Filter",
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: SalColors.black))),
          tilePadding: EdgeInsets.only(left: 0.0),
          trailing: Image.asset(
            this.isExpanded
                ? "assets/images/minimize.png"
                : "assets/images/expand.png",
            width: 24,
            height: 24,
          ),
          children: [
            _languageSection(provider),
            SizedBox(height: 8),
            _dateSection(),
            SizedBox(height: 20),
            _priceRow()
          ],
          onExpansionChanged: (bool expanded) {
            setState(() {
              this.isExpanded = expanded;
            });
          }),
    );
  }

  Container _languageSection(FiltersProvider provider) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Language",
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: SalColors.blue)),
          ),
          SizedBox(height: 12),
          Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: SalColors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  isExpanded: true,
                  autofocus: false,
                  underline: Container(color: Colors.transparent),
                  hint: Text("Select Language", style: fieldTextStyle()),
                  style: fieldTextStyle(),
                  value: provider.getLanguage(),
                  icon: Icon(Icons.keyboard_arrow_down),
                  elevation: 8,
                  iconSize: 24,
                  items: Provider.of<FiltersProvider>(context, listen: false)
                      .getAllLanguages()
                      .map((value) =>
                          DropdownMenuItem(child: Text(value), value: value))
                      .toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      provider.setLanguage(newValue);
                    });
                  },
                ),
              ))
        ],
      ),
    );
  }

  Container _dateSection() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Date",
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: SalColors.blue)),
          ),
          SizedBox(height: 12),
          Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: SalColors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text("Select Date", style: fieldTextStyle()),
                      ),
                      Icon(Icons.keyboard_arrow_right),
                    ]),
              ))
        ],
      ),
    );
  }

  Widget _priceRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
            child: Text(
              "Price",
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: SalColors.blue)),
            ),
          ),
          Image.asset(
            "assets/images/rupee.png",
            width: 18,
            height: 18,
          ),
          Text(
            '${Provider.of<FiltersProvider>(context, listen: false).displayPriceRange()}',
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: SalColors.steelGrey)),
          ),
        ]),
        RangeSlider(
            min: 0,
            max: 5000.0,
            divisions: 100,
            activeColor: SalColors.blue,
            inactiveColor: SalColors.grey,
            values:
                Provider.of<FiltersProvider>(context, listen: false).priceRange,
            onChanged: (value) {
              setState(() {
                Provider.of<FiltersProvider>(context, listen: false)
                    .priceRange = value;
              });
            })
      ],
    );
  }

  TextStyle fieldTextStyle() {
    return GoogleFonts.openSans(
        textStyle: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, color: SalColors.grey));
  }
}
