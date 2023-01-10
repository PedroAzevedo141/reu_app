import 'package:flutter/material.dart';

class ResidentsPage extends StatefulWidget {
  const ResidentsPage({Key? key}) : super(key: key);

  @override
  State<ResidentsPage> createState() => _ResidentsPageState();
}

class _ResidentsPageState extends State<ResidentsPage> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Index 0: Lista de Residentes',
      style: optionStyle,
    );
  }
}
