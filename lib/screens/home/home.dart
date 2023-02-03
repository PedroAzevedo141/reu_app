import 'package:flutter/material.dart';
import 'package:reu_app/components/header_with_seachbox.dart';
import 'package:reu_app/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                title: const Text("Pagina Inicial"),
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
