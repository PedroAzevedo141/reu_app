import 'package:flutter/material.dart';

import '../components/header_with_seachbox.dart';
import '../main.dart';
import '../repositories/reu_repository.dart';

class WarningPage extends StatefulWidget {
  const WarningPage({Key? key}) : super(key: key);

  @override
  State<WarningPage> createState() => _WarningPageState();
}

class _WarningPageState extends State<WarningPage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final ReuRepository reuRepository = ReuRepository();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        HeaderWithSearchBox(size: size),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              const Text(
                'Index 3: Quadro de Avisos',
                style: optionStyle,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                height: 150,
                width: double.maxFinite,
                child: const Card(
                  elevation: 5,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                height: 150,
                width: double.maxFinite,
                child: const Card(
                  elevation: 5,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                height: 150,
                width: double.maxFinite,
                child: const Card(
                  elevation: 5,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                height: 150,
                width: double.maxFinite,
                child: const Card(
                  elevation: 5,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                height: 150,
                width: double.maxFinite,
                child: const Card(
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
