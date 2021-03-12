import 'package:flutter/material.dart';
import 'package:SAL_App/UI/Models/Practioner.dart';
import 'package:SAL_App/Network/HttpClient.dart';
import 'package:SAL_App/UI/PractionerCard.dart';
import 'package:SAL_App/UI/PractionerDetailsView.dart';

class PractionersListView extends StatefulWidget {
  final bool disableScrolling;

  const PractionersListView({Key key, this.disableScrolling}) : super(key: key);

  @override
  _PractionersListViewState createState() => _PractionersListViewState();
}

class _PractionersListViewState extends State<PractionersListView> {
  // Constants
  final xPaddding = 16.0;
  final yPaddding = 4.0;

  Future<List<Practioner>> _practioners;

  @override
  void initState() {
    super.initState();
    this._practioners = HttpClient.shared.getPractioners();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder(
          future: this._practioners,
          builder: (context, AsyncSnapshot<List<Practioner>> snapshot) {
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
                      Practioner practioner = snapshot.data[idx];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: this.yPaddding,
                            horizontal: this.xPaddding),
                        child: buildCard(practioner),
                      );
                    });
            }
          }),
    );
  }

  InkWell buildCard(Practioner practioner) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PractionerDetailsView()));
        },
        child: PractionerCard(practioner: practioner));
  }
}
