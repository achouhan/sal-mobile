import 'package:sal_patient_client/common/sal_colors.dart';
import 'package:sal_patient_client/common/sal_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sal_patient_client/ui/practioners_view.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sal_patient_client/providers/filters_provider.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(ChangeNotifierProvider(
      create: (_) => FiltersProvider(), child: SALApp()));
}

class SALApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAL',
      theme: SALTheme.appTheme,
      home: SALAppPage(title: 'SAL Patient App'),
    );
  }
}

class SALAppPage extends StatefulWidget {
  SALAppPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SALAppPageState createState() => _SALAppPageState();
}

class _SALAppPageState extends State<SALAppPage> {
  int _currentIndex = 0;
  final double iconWidth = 24;
  final double iconHeight = 24;

  final List<Widget> _children = [
    Center(child: Text("Home")),
    PractionersView(),
    Center(child: Text("Explore")),
    Center(child: Text("More"))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        selectedItemColor: SalColors.blue,
        unselectedItemColor: SalColors.grey,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/home.png",
                  width: this.iconWidth,
                  height: this.iconHeight,
                  color: SalColors.grey),
              activeIcon: Image.asset("assets/images/home.png",
                  width: this.iconWidth, height: this.iconHeight),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/connect.png",
                width: this.iconWidth,
                height: this.iconHeight,
                color: SalColors.grey,
              ),
              activeIcon: Image.asset("assets/images/connect.png",
                  width: this.iconWidth,
                  height: this.iconHeight,
                  color: SalColors.blue),
              label: "Connect"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/explore.png",
                width: this.iconWidth,
                height: this.iconHeight,
                color: SalColors.grey,
              ),
              activeIcon: Image.asset("assets/images/explore.png",
                  width: this.iconWidth,
                  height: this.iconHeight,
                  color: SalColors.blue),
              label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "More")
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
