import 'package:flutter/material.dart';
import 'package:reu_app/constants.dart';
import 'package:reu_app/warnings/models/warning_models.dart';
import 'package:reu_app/warnings/warning_list_item.dart';

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

  List<WarningModels> warningsList = [];

  WarningModels? deletedWarning;
  int? deletedWarningPos;

  final TextEditingController warningControllerTitle = TextEditingController();
  final TextEditingController warningControllerDesc = TextEditingController();
  final TextEditingController warningControllerUser = TextEditingController();

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
              for (WarningModels war in warningsList)
                WarningListItem(
                  newWarning: war,
                  onDelete: onDelete,
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
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

  void onDelete(WarningModels war) {
    deletedWarning = war;
    deletedWarningPos = warningsList.indexOf(war);

    setState(() {
      warningsList.remove(war);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'O aviso ${war.title} foi removido com sucesso!',
        style: const TextStyle(
          color: Color(0xff060708),
        ),
      ),
      backgroundColor: const Color(0xffA6E1FA),
      action: SnackBarAction(
        label: "Desfazer",
        textColor: const Color(0xff0E6BA8),
        onPressed: () {
          setState(() {
            warningsList.insert(deletedWarningPos!, deletedWarning!);
          });
        },
      ),
      duration: const Duration(seconds: 5),
    ));
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
                      controller: warningControllerTitle,
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
                      controller: warningControllerDesc,
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
                            WarningModels newWarning = WarningModels(
                              title: warningControllerTitle.text,
                              descricao: warningControllerDesc.text,
                              user: "Pedro Azevedo",
                              dateTime: DateTime.now(),
                            );
                            warningsList.add(newWarning);
                          });
                          print(warningsList);
                          clearController();
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

  void clearController() {
    warningControllerTitle.clear();
    warningControllerDesc.clear();
    warningControllerUser.clear();
  }
}
