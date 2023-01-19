import 'package:flutter/material.dart';

import '../components/header_with_seachbox.dart';
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
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          const Text(
            'Index 3: Quadro de Avisos',
            style: optionStyle,
          ),

          // TitleWithMoreBtn(title: "Recomended", press: () {}),
          // RecomendsPlants(),
          // TitleWithMoreBtn(title: "Featured Plants", press: () {}),
          // FeaturedPlants(),
          // SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
