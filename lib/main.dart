import 'package:sal_patient_client/common/sal_colors.dart';
import 'package:sal_patient_client/common/sal_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sal_patient_client/network/APIProvider.dart';
import 'package:sal_patient_client/ui/practitioners_view.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sal_patient_client/providers/filters_provider.dart';

import 'network/metadata_repository.dart';
import 'network/practitioner_repository.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FiltersProvider()),
        Provider(create: (context) => PractitionerRepository(APIProvider())),
        Provider(create: (context) => MetadataRepository(APIProvider())),
      ],
      child: SALApp(),
    ),
  );
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
  bool isReady = false;

  final List<Widget> _children = [
    Center(child: Text("Home")),
    PractitionersView(),
    Center(child: Text("Explore")),
    Center(child: Text("More"))
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<FiltersProvider>(context)
        .loadMetadata(Provider.of<MetadataRepository>(context, listen: false))
        .then((value) async {
      setState(() {
        this.isReady = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return this.isReady
        ? _buildScaffold(context)
        : Container(
            color: SalColors.blue,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
                child:
                    CircularProgressIndicator(backgroundColor: Colors.white)));
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(index: this._currentIndex, children: _children),
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
