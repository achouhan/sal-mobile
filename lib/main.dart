import 'package:sal_patient_client/utils/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sal_patient_client/ui/practioners_view.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sal_patient_client/providers/filters_provider.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(
      ChangeNotifierProvider(create: (_) => FiltersProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        selectedItemColor: kSalThemeColor,
        unselectedItemColor: Colors.grey,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          BottomNavigationBarItem(
              icon: Image.asset("icons/home.png",
                  width: this.iconWidth,
                  height: this.iconHeight,
                  color: Colors.grey),
              activeIcon: Image.asset("icons/home.png",
                  width: this.iconWidth,
                  height: this.iconHeight,
                  color: kSalThemeColor),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "icons/connect.png",
                width: this.iconWidth,
                height: this.iconHeight,
                color: Colors.grey,
              ),
              activeIcon: Image.asset("icons/connect.png",
                  width: this.iconWidth,
                  height: this.iconHeight,
                  color: kSalThemeColor),
              label: "Connect"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "icons/explore.png",
                width: this.iconWidth,
                height: this.iconHeight,
                color: Colors.grey,
              ),
              activeIcon: Image.asset("icons/explore.png",
                  width: this.iconWidth,
                  height: this.iconHeight,
                  color: kSalThemeColor),
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
