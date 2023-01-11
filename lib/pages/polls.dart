import 'package:flutter/material.dart';

import '../main.dart';

class PoolPage extends StatefulWidget {
  const PoolPage({Key? key}) : super(key: key);

  @override
  State<PoolPage> createState() => _PoolPageState();
}

class _PoolPageState extends State<PoolPage> {
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
              'Index 4: Enquetes',
              style: optionStyle,
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
