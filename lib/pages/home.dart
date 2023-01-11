import 'package:flutter/material.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        ElevatedCardExample(),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Center(
            child: Text(
              'Index 2: Pagina Inicial',
              style: optionStyle,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
