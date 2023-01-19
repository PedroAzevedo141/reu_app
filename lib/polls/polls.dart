import 'package:flutter/material.dart';

import '../components/header_with_seachbox.dart';
import '../main.dart';

class PoolPage extends StatefulWidget {
  const PoolPage({Key? key}) : super(key: key);

  @override
  State<PoolPage> createState() => _PoolPageState();
}

class _PoolPageState extends State<PoolPage> {
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
            'Index 4: Enquetes',
            style: optionStyle,
          ),
          const Padding(padding: EdgeInsets.all(400)),

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
