import 'package:flutter/material.dart';

import '../main.dart';

class WarningPage extends StatefulWidget {
  const WarningPage({Key? key}) : super(key: key);

  @override
  State<WarningPage> createState() => _WarningPageState();
}

class _WarningPageState extends State<WarningPage> {
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
              'Index 3: Quadro de Avisos',
              style: optionStyle,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
