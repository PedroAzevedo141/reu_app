import 'package:flutter/material.dart';
import 'package:reu_app/constants.dart';

import '../../components/header_with_seachbox.dart';

class ResidentsPage extends StatefulWidget {
  const ResidentsPage({Key? key}) : super(key: key);

  @override
  State<ResidentsPage> createState() => _ResidentsPageState();
}

class _ResidentsPageState extends State<ResidentsPage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: kPrimaryColor,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Lista de Residentes"),
                centerTitle: true,
              ),
            ),
            SliverToBoxAdapter(
              child: HeaderWithSearchBox(size: size),
            ),
            SliverToBoxAdapter(
              child: const Padding(padding: EdgeInsets.all(400)),
            )
          ],
        )
      ],
    );
  }
}