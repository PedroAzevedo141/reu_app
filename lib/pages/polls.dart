import 'package:flutter/material.dart';

class PoolPage extends StatefulWidget {
  const PoolPage({Key? key}) : super(key: key);

  @override
  State<PoolPage> createState() => _PoolPageState();
}

class _PoolPageState extends State<PoolPage> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Index 4: Enquetes',
      style: optionStyle,
    );
  }
}
