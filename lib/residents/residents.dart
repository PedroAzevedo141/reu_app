import 'package:flutter/material.dart';

import '../components/header_with_seachbox.dart';
import '../main.dart';

class ResidentsPage extends StatefulWidget {
  const ResidentsPage({Key? key}) : super(key: key);

  @override
  State<ResidentsPage> createState() => _ResidentsPageState();
}

class _ResidentsPageState extends State<ResidentsPage> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          const Text(
            'Index 0: Lista de Residentes',
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
