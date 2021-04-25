import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sal_patient_client/common/sal_colors.dart';

typedef void AvailabilityTimeSelectedFunction(DateTime time);

class AvailabilityTimesGridView extends StatelessWidget {
  final List<DateTime> availabilityTimes;
  final AvailabilityTimeSelectedFunction onSelected;
  final DateTime selectedTime;

  AvailabilityTimesGridView(
      {Key key, this.availabilityTimes, this.onSelected, this.selectedTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 75,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: availabilityTimes.length,
        itemBuilder: (BuildContext ctx, index) {
          return AvailabilityTimeGridCell(
            availabilityTime: availabilityTimes[index],
            onSelected: this.onSelected,
            isSelected: availabilityTimes[index] == selectedTime,
          );
        });
  }
}

class AvailabilityTimeGridCell extends StatelessWidget {
  final DateTime availabilityTime;
  final AvailabilityTimeSelectedFunction onSelected;
  final bool isSelected;

  AvailabilityTimeGridCell(
      {this.availabilityTime, this.onSelected, this.isSelected});

  String get _title {
    var formatter = DateFormat('j');
    return formatter.format(availabilityTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
          onPressed: () {
            onSelected(availabilityTime);
          },
          style: TextButton.styleFrom(
              backgroundColor: this.isSelected ? SalColors.blue : Colors.white),
          child: Text(
            _title.toUpperCase(),
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: this.isSelected ? Colors.white : SalColors.black)),
          )),
    );
  }
}
