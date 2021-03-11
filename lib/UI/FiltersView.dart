import 'package:SAL_App/UI/Models/Practioner.dart';
import 'package:SAL_App/UI/PractionersSearchResultsView.dart';
import 'package:SAL_App/Utils/RoundedButton.dart';
import 'package:SAL_App/Utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltersView extends StatefulWidget {
  @override
  _FiltersViewState createState() => _FiltersViewState();
}

class _FiltersViewState extends State<FiltersView> {
  // To Keep track of practioner type selected by user
  Set<PractionerType> type = Set();

  // List of possible topics(Hard coded for now)
  final topics = [
    'Anxiety Management',
    'Stress - Work / Personal Relationship',
    'Depression',
    'Anger Management',
    'Parenting',
    'Teenage Tantrums',
    'Grief / Trauma',
    'Self-Improvement / Motivation',
    'Life Coaching',
    'Others'
  ];

  final languages = [
    'English',
    'Hindi',
  ];

  String selectedTopic;
  String selectedLanguage;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderRow(),
          SizedBox(height: 16),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildToggleButton(PractionerType.counsellor),
                buildToggleButton(PractionerType.listener)
              ]),
          SizedBox(height: 16),
          _topicSection(),
          SizedBox(height: 16),
          _advanceSection(),
          SizedBox(height: 16),
          _buttonSection()
        ],
      ),
    );
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
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => PractionersSearchResultsView()));
          },
          color: kSalThemeColor,
          textColor: Colors.white,
        ),
      )
    ]);
  }

  Container _topicSection() {
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
                  color:
                      this.type.contains(type) ? kSalThemeColor : Colors.white,
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
                  value: this.selectedTopic,
                  icon: Icon(Icons.keyboard_arrow_down),
                  elevation: 8,
                  iconSize: 24,
                  items: this
                      .topics
                      .map((value) =>
                          DropdownMenuItem(child: Text(value), value: value))
                      .toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      this.selectedTopic = newValue;
                    });
                  },
                ),
              ))
        ],
      ),
    );
  }

  Widget _HeaderRow() {
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

  GestureDetector buildToggleButton(PractionerType type) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (this.type.contains(type)) {
            this.type.remove(type);
          } else {
            this.type.add(type);
          }
        });
      },
      child: Container(
        width: 156,
        height: 40,
        decoration: BoxDecoration(
            color: this.type.contains(type) ? kSalThemeColor : Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Center(
          child: Text(
              type == PractionerType.counsellor ? "Counsellor" : "Listener",
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: this.type.contains(type)
                          ? Colors.white
                          : kGreytextColor))),
        ),
      ),
    );
  }

  Widget _advanceSection() {
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
          children: [_languageSection(), SizedBox(height: 8), _dateSection()],
          onExpansionChanged: (bool expanded) {
            setState(() {
              this.isExpanded = expanded;
            });
          }),
    );
  }

  Container _languageSection() {
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
                  color:
                      this.type.contains(type) ? kSalThemeColor : Colors.white,
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
                  value: this.selectedLanguage,
                  icon: Icon(Icons.keyboard_arrow_down),
                  elevation: 8,
                  iconSize: 24,
                  items: this
                      .languages
                      .map((value) =>
                          DropdownMenuItem(child: Text(value), value: value))
                      .toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      this.selectedLanguage = newValue;
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
                    color: Color(0xFF0066B3))),
          ),
          SizedBox(height: 12),
          Container(
              height: 40,
              decoration: BoxDecoration(
                  color:
                      this.type.contains(type) ? kSalThemeColor : Colors.white,
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
