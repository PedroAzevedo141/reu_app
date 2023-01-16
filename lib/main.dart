import 'package:flutter/material.dart';
import 'package:reu_app/pages/home.dart';
import 'package:reu_app/pages/activity.dart';
import 'package:reu_app/pages/residents.dart';
import 'package:reu_app/pages/warnings.dart';
import 'package:reu_app/pages/polls.dart';

void main() => runApp(const MyApp());

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF564256),
        title: const Text('REU APP'),
        actions: <Widget>[
          IconButton(
            iconSize: 30,
            padding: const EdgeInsets.only(right: 20),
            icon: const Icon(Icons.settings),
            tooltip: 'Show Snackbar',
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}

class ElevatedCardExample extends StatelessWidget {
  const ElevatedCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: const Color(0xFF96939B),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: const <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Usuario:\tPedro Azevedo\n'
                      'Morador:\tAtivo\n'
                      'Ativo desde:\t01/01/2018',
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.transparent,
                  child: FlutterLogo(size: 80),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
