import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

modalBottomPolls(context) {
  final ButtonStyle style = ElevatedButton.styleFrom(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
    minimumSize: const Size(140, 50),
    backgroundColor: kButtomColor,
  );

  CollectionReference polls = FirebaseFirestore.instance.collection('polls');

  final TextEditingController pollControllerTitle = TextEditingController();
  final TextEditingController pollcontrollertitleAwenser1 =
      TextEditingController();
  final TextEditingController pollcontrollertitleAwenser2 =
      TextEditingController();
  final TextEditingController pollcontrollertitleAwenser3 =
      TextEditingController();

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
                      "Insira uma nova enquete",
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
                    controller: pollControllerTitle,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Insira o titulo da enquete',
                      labelText: ' Titulo',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 24, left: 28, right: 28),
                  child: TextFormField(
                    controller: pollcontrollertitleAwenser1,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Insira a primeira opção',
                      labelText: ' Opção 1',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 24, left: 28, right: 28),
                  child: TextFormField(
                    controller: pollcontrollertitleAwenser2,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Insira a segunda opção',
                      labelText: ' Opção 2',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 24, left: 28, right: 28),
                  child: TextFormField(
                    controller: pollcontrollertitleAwenser3,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Insira a terceira opção',
                      labelText: ' Opção 3',
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
                        if (pollControllerTitle.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Falta informacoes!"),
                              content:
                                  const Text("Informe o titulo da enquete..."),
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

                        if (pollControllerTitle.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Falta informacoes!"),
                              content:
                                  const Text("Informe o titulo da enquete..."),
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

                        if (conditionAnswer(
                            pollcontrollertitleAwenser1,
                            pollcontrollertitleAwenser2,
                            pollcontrollertitleAwenser3)) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Falta informacoes!"),
                              content: const Text(
                                  "Informe pelo menos duas opções de resposta..."),
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

                        addPoll(
                            polls,
                            pollControllerTitle,
                            pollcontrollertitleAwenser1,
                            pollcontrollertitleAwenser2,
                            pollcontrollertitleAwenser3);

                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Criar a enquete',
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

Future<void> addPoll(polls, pollControllerTitle, pollcontrollertitleAwenser1,
    pollcontrollertitleAwenser2, pollcontrollertitleAwenser3) async {
  Map<String, dynamic> userData = {};
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? firebaseUser = _auth.currentUser;
  if (firebaseUser != null) {
    DocumentSnapshot docUser = await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .get();
    userData = docUser.data() as Map<String, dynamic>;

    polls.add({
      'title': pollControllerTitle.text,
      'awenser1': pollcontrollertitleAwenser1.text,
      'awenser2': pollcontrollertitleAwenser2.text,
      'awenser3': pollcontrollertitleAwenser3.text,
      'awenser1_count': 0,
      'awenser2_count': 0,
      'awenser3_count': 0,
      'dateTime': DateTime.now().toIso8601String(),
      'user_Name': userData["name"],
      'user_ID': firebaseUser.uid,
    });
  }
}

conditionAnswer(pollcontrollertitleAwenser1, pollcontrollertitleAwenser2,
    pollcontrollertitleAwenser3) {
  if (pollcontrollertitleAwenser1.text.isEmpty &&
      pollcontrollertitleAwenser2.text.isEmpty) {
    return true;
  }
  if (pollcontrollertitleAwenser1.text.isEmpty &&
      pollcontrollertitleAwenser3.text.isEmpty) {
    return true;
  }
  if (pollcontrollertitleAwenser3.text.isEmpty &&
      pollcontrollertitleAwenser2.text.isEmpty) {
    return true;
  }
  return false;
}
