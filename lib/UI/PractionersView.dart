import 'package:SAL_App/UI/FiltersView.dart';
import 'package:SAL_App/Utils/styles.dart';
import 'package:SAL_App/UI/PractionersListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PractionersView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PractionersViewState();
}

class PractionersViewState extends State<PractionersView> {
  
  final ScrollController _scrollController = ScrollController();
  bool _showFilterButton = false;
  double _viewHeight = 0;

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
    this._viewHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
          bottomOpacity: 0.0,
          title: Text("Filter Search", style: kTitleTextStyle),
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
          PractionersListView(disableScrolling: true)
        ])));
  }

  void setupScrollViewController() async {
    this._scrollController.addListener(() {
      if (this._scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          this._scrollController.offset >= this._viewHeight / 2) {
        setState(() {
          this._showFilterButton = true;
        });
      } else if (this._scrollController.offset < this._viewHeight / 2) {
        setState(() {
          this._showFilterButton = false;
        });
      }
    });
  }
}
