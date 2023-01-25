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

  EdgeInsets marginCards = const EdgeInsets.only(bottom: 25);

  static List<List> warnings_list = [];
  final TextEditingController warningController_title = TextEditingController();
  final TextEditingController warningController_desc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        HeaderWithSearchBox(size: size),
        const Text(
          'Index 3: Quadro de Avisos',
          style: optionStyle,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(left: 26, right: 26, top: 16),
            shrinkWrap: true,
            children: <Widget>[
              Card(
                elevation: 5,
                margin: marginCards,
                child: ExpansionTile(
                  title: Text('Titulo do aviso 1'),
                  subtitle: Text('Enviado por: NOMEDOCRIADOR'),
                  children: <Widget>[
                    // for (String war in WarningPage.warnings_list)
                    ListTile(
                      title: Center(child: Text("AVISO 01")),
                      subtitle: Center(
                          child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")),
                      leading: Icon(Icons.person),
                      onTap: () {
                        print("Teste 01");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
