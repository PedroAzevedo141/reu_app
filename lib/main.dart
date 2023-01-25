import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reu_app/constants.dart';
import 'package:reu_app/home/home.dart';
import 'package:reu_app/activity/activity.dart';
import 'package:reu_app/residents/residents.dart';
import 'package:reu_app/warnings/warnings.dart';
import 'package:reu_app/polls/polls.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());

  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // firestore.collection("products").add({
  //   'Nome': "Pedro",
  //   'Number': "81995636499",
  // }).then((value) => print("OPAAAAAAAAAAAA"));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: kPrimaryColor,
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/menu.svg"),
      onPressed: () {},
    ),
  );
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 2;
  static const List<Widget> _widgetOptions = <Widget>[
    ResidentsPage(),
    ActivityPage(),
    HomePage(),
    WarningPage(),
    PoolPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: _widgetOptions.elementAt(_selectedIndex),
        // floatingActionButton: buildFloatingAction(_selectedIndex, context),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 28,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.groups),
              label: 'Residentes',
              backgroundColor: kPrimaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Atividades',
              backgroundColor: kPrimaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
              backgroundColor: kPrimaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.warning),
              label: 'Avisos',
              backgroundColor: kPrimaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.poll),
              label: 'Enquetes',
              backgroundColor: kPrimaryColor,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFFC814A),
          unselectedItemColor: const Color(0xFFFFFFFF),
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
