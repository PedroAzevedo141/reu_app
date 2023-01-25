import 'package:flutter/material.dart';
import 'package:reu_app/constants.dart';
import 'package:reu_app/warnings/warning_list_item.dart';

import '../components/header_with_seachbox.dart';
import '../main.dart';
import '../repositories/reu_repository.dart';

class WarningPage extends StatefulWidget {
  const WarningPage({Key? key}) : super(key: key);

  @override
  State<WarningPage> createState() => _WarningPageState();

  void modalBottom(context) {}
}

class _WarningPageState extends State<WarningPage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final ReuRepository reuRepository = ReuRepository();

  List<dynamic> warnings_list = [];
  final TextEditingController warningController_title = TextEditingController();
  final TextEditingController warningController_desc = TextEditingController();
  final TextEditingController warningController_user = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        HeaderWithSearchBox(size: size),
        const Text(
          'Quadro de avisos!',
          style: optionStyle,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(left: 26, right: 26, top: 16),
            shrinkWrap: true,
            children: <Widget>[
              for (Map war in warnings_list)
                WarningListItem(
                  message: war,
                ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                onPressed: () {
                  modalBottom(context);
                },
                backgroundColor: const Color(0xFF82BB92),
                foregroundColor: Colors.white,
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {
                  // modalBottom(context);
                },
                backgroundColor: const Color(0xFFF0C808),
                foregroundColor: Colors.white,
                child: const Icon(Icons.done_all),
              ),
              FloatingActionButton(
                onPressed: () {
                  // modalBottom(context);
                },
                backgroundColor: const Color(0xFFDD1C1A),
                foregroundColor: Colors.white,
                child: const Icon(Icons.delete_forever),
              ),
            ],
          ),
        ),
      ],
    );
  }

  modalBottom(context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
      minimumSize: const Size(120, 40),
      backgroundColor: kButtomColor,
    );

    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 24, left: 16, right: 16),
                    child: Center(
                      child: Text(
                        "Insira um novo aviso",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 24, left: 16, right: 16),
                    child: TextFormField(
                      controller: warningController_title,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Insira o titulo do aviso',
                        labelText: ' Titulo',
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 24, left: 16, right: 16),
                    child: TextFormField(
                      controller: warningController_desc,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Detalhes do aviso',
                        labelText: ' Insira o aviso...',
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 24, left: 16, right: 16),
                    child: Center(
                      child: ElevatedButton(
                        style: style,
                        onPressed: () {
                          setState(() {
                            warnings_list.add({
                              'title': warningController_title.text,
                              'desc': warningController_desc.text,
                              // 'user': warningController_user.text,
                              'user': "Pedro Azevedo",
                            });
                          });
                          warningController_title.clear();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Enviar',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
