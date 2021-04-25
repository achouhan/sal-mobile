import 'package:flutter/material.dart';
import 'package:sal_patient_client/models/practitioner.dart';
import 'package:sal_patient_client/network/http_client.dart';
import 'package:sal_patient_client/ui/practitioner_card_view.dart';
import 'package:sal_patient_client/ui/practitioner_details_view.dart';

class PractitionersListWidget extends StatefulWidget {
  final bool disableScrolling;

  const PractitionersListWidget({Key key, this.disableScrolling})
      : super(key: key);

  @override
  _PractitionersListWidgetState createState() =>
      _PractitionersListWidgetState();
}

class _PractitionersListWidgetState extends State<PractitionersListWidget> {
  // Constants
  final xPaddding = 16.0;
  final yPaddding = 4.0;

  Future<List<Practitioner>> _practitioners;

  @override
  void initState() {
    super.initState();
    this._practitioners = HttpClient.shared.getPractitioners();
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
                  return Text("Invalid data returned");
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
                  builder: (context) => PractitionerDetailsWidget(
                        practitioner: practitioner,
                      )));
        },
        child: PractitionerCard(practitioner: practitioner));
  }
}
