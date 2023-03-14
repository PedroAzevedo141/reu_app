import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reu_app/models/user_model.dart';

import '../../constants.dart';

modalBottom(context, warningControllerTitle, warningControllerDesc,
    warningControllerUser) {
  final ButtonStyle style = ElevatedButton.styleFrom(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
    minimumSize: const Size(120, 40),
    backgroundColor: kButtomColor,
  );

  CollectionReference warnings =
      FirebaseFirestore.instance.collection('warnings');

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
                      labelText: 'Detalhes do aviso',
                      hintText: ' Insira a descricao do aviso...',
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
                        String title = warningControllerTitle.text;
                        String desc = warningControllerDesc.text;

                        if (title.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Falta informacoes!"),
                              content:
                                  const Text("Informe o titulo do aviso..."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.black),
                                  child: const Text("Voltar"),
                                ),
                              ],
                            ),
                          );
                          return;
                        }

                        if (desc.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Falta informacoes!"),
                              content:
                                  const Text("Informe a descricao do aviso..."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.black),
                                  child: const Text("Voltar"),
                                ),
                              ],
                            ),
                          );
                          return;
                        }

                        addWarning(warnings, warningControllerTitle.text,
                            warningControllerDesc.text);

                        warningControllerTitle.clear();
                        warningControllerDesc.clear();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Enviar o aviso',
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

Future<void> addWarning(warnings, title, desc) async {
  Map<String, dynamic> userData = {};
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? firebaseUser = _auth.currentUser;
  if (firebaseUser != null) {
    DocumentSnapshot docUser = await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .get();
    userData = docUser.data() as Map<String, dynamic>;

    warnings.add({
      'title': title,
      'description': desc,
      'type_warning': userData["type"],
      'user_ID': firebaseUser.uid,
      'warning_read': "0",
      'dateTime': DateTime.now().toIso8601String(),
    });
  }
}
