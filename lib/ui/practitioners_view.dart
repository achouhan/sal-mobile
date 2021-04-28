import 'package:provider/provider.dart';
import 'package:sal_patient_client/providers/filters_provider.dart';
import 'package:sal_patient_client/ui/filters_view.dart';
import 'package:sal_patient_client/ui/practitioners_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sal_patient_client/common/sal_colors.dart';

class PractitionersView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PractitionersViewState();
}

class PractitionersViewState extends State<PractitionersView> {
  final ScrollController _scrollController = ScrollController();
  bool _showFilterButton = false;
  double _widgetHeight = 0;


  @override
  void initState() {
    super.initState();
    setupScrollViewController();
  }

  @override
  void dispose() {
    // Remove scroll view listener
    this._scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this._widgetHeight = MediaQuery.of(context).size.height;
    return Consumer<FiltersProvider>(builder: (context, provider, child) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
          bottomOpacity: 0.0,
          title: Text("Filter Search", style: SalStyles.titleTextStyle),
        ),
        floatingActionButton: AnimatedOpacity(
          duration: Duration(milliseconds: 100),
          opacity: this._showFilterButton ? 1 : 0,
          child: FloatingActionButton(
            onPressed: () {
              this._scrollController.animateTo(0,
                  duration: Duration(milliseconds: 100), curve: Curves.ease);
            },
            child: Icon(Icons.add),
          ),
        ),
        body: SafeArea(
            child: ListView(controller: this._scrollController, children: [
          FiltersView(),
          new PractitionersListView(disableScrolling: true, filters:provider.getQueryFilters())
        ])));
    });
  }

  void setupScrollViewController() async {
    this._scrollController.addListener(() {
      if (this._scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          this._scrollController.offset >= this._widgetHeight / 2) {
        setState(() {
          this._showFilterButton = true;
        });
      } else if (this._scrollController.offset < this._widgetHeight / 2) {
        setState(() {
          this._showFilterButton = false;
        });
      }
    });
  }
}
