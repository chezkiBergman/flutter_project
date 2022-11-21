// import 'dart:ffi';
import 'package:flutter_application_1/getData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Filter & Search ListView';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: buildBottomBar(),
        body: buildPages(),
      );

  Widget buildBottomBar() {
    final style = TextStyle(color: Colors.white);

    return BottomNavigationBar(
      // backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Color.fromARGB(255, 102, 167, 199),
      currentIndex: index,
      items: const <BottomNavigationBarItem>[
      
        BottomNavigationBarItem(
          icon: Icon(Icons.movie),
          label: 'חיפוש סרטים',
        ),

          BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),

        // BottomNavigationBarItem(
        //   icon: Icon(Icons),
        //   label: 'School',
        // ),
      ],
      onTap: (int index) => setState(() => this.index = index),
    );
  }

  Widget buildPages() {
    switch (index) {
      case 0:
        return FilterMoviesByName();
      default:
        return Container();
    }
  }
}
