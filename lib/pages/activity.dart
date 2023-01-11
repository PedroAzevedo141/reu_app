import 'package:flutter/material.dart';

import '../main.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        ElevatedCardExample(),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Center(
            child: Text(
              'Index 1: Calendario de Atividades',
              style: optionStyle,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}

