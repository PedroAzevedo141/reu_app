import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reu_app/home/home.dart';
import 'package:reu_app/activity/activity.dart';
import 'package:reu_app/residents/residents.dart';
import 'package:reu_app/warnings/auxiliary_func.dart';
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
    backgroundColor: const Color(0xFF564256),
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/menu.svg"),
      onPressed: () {},
    ),
  );
}

FloatingActionButton? buildFloatingAction(index, context) {
  if (index == 3) {
    return FloatingActionButton(
      onPressed: () {
        modalBottom(context);
      },
      backgroundColor: const Color(0xFF564256),
      foregroundColor: Colors.white,
      child: const Icon(Icons.add),
    );
  }
  return null;
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
        floatingActionButton: buildFloatingAction(_selectedIndex, context),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 28,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.groups),
              label: 'Residentes',
              backgroundColor: Color(0xFF564256),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Atividades',
              backgroundColor: Color(0xFF564256),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
              backgroundColor: Color(0xFF564256),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.warning),
              label: 'Avisos',
              backgroundColor: Color(0xFF564256),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.poll),
              label: 'Enquetes',
              backgroundColor: Color(0xFF564256),
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
