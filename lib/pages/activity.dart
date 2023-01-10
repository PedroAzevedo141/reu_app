import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Index 1: Calendario de Atividades',
      style: optionStyle,
    );
  }
}

