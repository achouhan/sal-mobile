import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:SAL_App/Providers/FiltersProvider.dart';
import 'package:SAL_App/UI/Models/Practioner.dart';
import 'package:SAL_App/UI/PractionersSearchResultsView.dart';
import 'package:SAL_App/Utils/RoundedButton.dart';
import 'package:SAL_App/Utils/styles.dart';


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
              children: FiltersProvider.getAllPractioners()
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
          onPressed: () {},
          color: Colors.white,
          textColor: kGreytextColor,
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        child: RoundedButton(
          title: 'SEARCH',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PractionersSearchResultsView()));
          },
          color: kSalThemeColor,
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
                    color: Color(0xFF0066B3))),
          ),
          SizedBox(height: 12),
          Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
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
                  items: FiltersProvider.getAllTopics()
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
                  color: Color(0xFF0066B3))),
        ),
      ),
      Image.asset(
        "icons/information.png",
        width: 24,
        height: 24,
      ),
      SizedBox(width: 8)
    ]);
  }

  GestureDetector buildToggleButton(
      PractionerType type, FiltersProvider provider) {
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
                provider.types.contains(type) ? kSalThemeColor : Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Center(
          child: Text(
              type == PractionerType.counsellor ? "Counsellor" : "Listener",
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: provider.types.contains(type)
                          ? Colors.white
                          : kGreytextColor))),
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
                      color: Colors.black))),
          tilePadding: EdgeInsets.only(left: 0.0),
          trailing: Image.asset(
            this.isExpanded ? "icons/minimize.png" : "icons/expand.png",
            width: 24,
            height: 24,
          ),
          children: [
            _languageSection(provider),
            SizedBox(height: 8),
            _dateSection()
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
                    color: Color(0xFF0066B3))),
          ),
          SizedBox(height: 12),
          Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
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
                  items: FiltersProvider.getAllLanguages()
                      .map((value) =>
                          DropdownMenuItem(child: Text(value), value: value))
                      .toList(),
                  onChanged: (String newValue) {
                    provider.setLanguage(newValue);
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
                    color: Color(0xFF0066B3))),
          ),
          SizedBox(height: 12),
          Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
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

  TextStyle fieldTextStyle() {
    return GoogleFonts.openSans(
        textStyle: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, color: kGreytextColor));
  }
}
