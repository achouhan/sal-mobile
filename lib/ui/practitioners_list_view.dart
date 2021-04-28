import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sal_patient_client/models/practitioner.dart';
import 'package:sal_patient_client/network/practitioner_repository.dart';
import 'package:sal_patient_client/ui/practitioner_card_view.dart';
import 'package:sal_patient_client/ui/practitioner_details_view.dart';

class PractitionersListView extends StatefulWidget {
  final bool disableScrolling;
  final Map<String, dynamic> filters;

  const PractitionersListView({Key key, this.disableScrolling, this.filters})
      : super(key: key);

  @override
  _PractitionersListViewState createState() => _PractitionersListViewState();
}

class _PractitionersListViewState extends State<PractitionersListView> {
  // Constants
  final xPaddding = 16.0;
  final yPaddding = 4.0;

  Future<List<Practitioner>> _practitioners;

  @override
  void initState() {
    super.initState();
    this._practitioners =
        Provider.of<PractitionerRepository>(context, listen: false)
            .getPractitioners(0, this.widget.filters);
  }

  @override
  void didUpdateWidget(covariant PractitionersListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!mapEquals(oldWidget.filters, this.widget.filters)) {
      setState(() {
        this._practitioners =
            Provider.of<PractitionerRepository>(context, listen: false)
                .getPractitioners(0, this.widget.filters);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder(
          future: this._practitioners,
          builder: (context, AsyncSnapshot<List<Practitioner>> snapshot) {
            assert(context != null);
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(
                      "Failed to download the data error ${snapshot.error}.");
                } else if (!snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Invalid data returned."),
                  );
                } else if (snapshot.data.length == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                        "No Practitioner was found. Please update your search criteria.",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black))),
                  );
                }

                // // Success case
                return ListView.builder(
                    shrinkWrap: true,
                    physics: (this.widget.disableScrolling == true)
                        ? NeverScrollableScrollPhysics()
                        : null,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, idx) {
                      Practitioner practitioner = snapshot.data[idx];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: this.yPaddding,
                            horizontal: this.xPaddding),
                        child: buildCard(practitioner),
                      );
                    });
            }
          }),
    );
  }

  InkWell buildCard(Practitioner practitioner) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PractitionerDetailsView(
                        practitioner: practitioner,
                      )));
        },
        child: PractitionerCard(practitioner: practitioner));
  }
}
