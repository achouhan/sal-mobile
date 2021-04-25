import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sal_patient_client/common/sal_colors.dart';
import 'package:sal_patient_client/models/practitioner.dart';
import 'package:sal_patient_client/utils/rounded_button.dart';
import 'package:table_calendar/table_calendar.dart';

import 'availability_times_grid_view.dart';

class PractitionerCalendarWidget extends StatefulWidget {
  final Practitioner practitioner;
  const PractitionerCalendarWidget({Key key, this.practitioner})
      : super(key: key);

  @override
  _PractitionerCalendarWidgetState createState() =>
      _PractitionerCalendarWidgetState();
}

class _PractitionerCalendarWidgetState
    extends State<PractitionerCalendarWidget> {
  // TODO: Ideally this should be set to the first availability day of the practitioner
  var _currentDate = DateTime.now();
  DateTime _selectedTime;

  // TODO: This is temporary until we figure out how to get available times for a practiotioner on a selected date
  final _mockedAvailableTimes = [
    DateTime.now(),
    DateTime.now().add(new Duration(hours: 1)),
    DateTime.now().add(new Duration(hours: 2)),
    DateTime.now().add(new Duration(hours: 3)),
    DateTime.now().add(new Duration(hours: 4)),
    DateTime.now().add(new Duration(hours: 5)),
    DateTime.now().add(new Duration(hours: 6)),
    DateTime.now().add(new Duration(hours: 7)),
    DateTime.now().add(new Duration(hours: 8)),
    DateTime.now().add(new Duration(hours: 9)),
  ];

  static TextStyle _normalTextStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: SalColors.black));

  static TextStyle _disableTextStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: SalColors.grey));

  static BoxDecoration _highlightedBoxDecoration = BoxDecoration(
      color: SalColors.blue,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(5.0)));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            backgroundColor: Colors.white,
            elevation: 0.0,
            bottomOpacity: 0.0,
            title: Text("Schedule", style: SalStyles.titleTextStyle),
            iconTheme: IconThemeData(
              color: SalColors.black,
            )),
        body: Align(
          alignment: Alignment.topCenter,
          child: _buildCalendarWidget(),
        ));
  }

  Widget _buildCalendarWidget() {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        TableCalendar(
          firstDay: DateTime.now(),
          focusedDay: _currentDate,
          lastDay: DateTime.now().add(Duration(days: 60)),
          calendarFormat: CalendarFormat.month,
          calendarStyle: CalendarStyle(
              defaultTextStyle: _normalTextStyle,
              disabledTextStyle: _disableTextStyle,
              selectedTextStyle: SalStyles.whiteTitleStyle,
              markerDecoration:
                  BoxDecoration(color: SalColors.blue, shape: BoxShape.circle),
              rangeHighlightColor: SalColors.blue,
              selectedDecoration: _highlightedBoxDecoration,
              todayDecoration: _highlightedBoxDecoration),
          headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextFormatter: (date, locale) {
                var formatter = new DateFormat('MMMM');
                return formatter.format(date);
              },
              titleTextStyle: SalStyles.subTitleTextStyle,
              headerPadding: EdgeInsets.symmetric(vertical: 10)),
          onDaySelected: (selectedDate, _) {
            this.setState(() {
              _currentDate = selectedDate;
            });
          },
        ),
        AvailabilityTimesGridView(
          availabilityTimes: _getAvailableTimes(),
          onSelected: (time) {
            this.setState(() {
              _selectedTime = time;
            });
          },
          selectedTime: this._selectedTime,
        ),
        RoundedButton(
          title: 'Next',
          onPressed: () {},
          color: SalColors.blue,
          textColor: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          enabled: _selectedTime != null,
        )
      ]),
    );
  }

  List<DateTime> _getAvailableTimes() {
    // TODO: We should ideally return availabilities via network call or practitioner model
    return _mockedAvailableTimes;
  }
}
