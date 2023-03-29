import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reu_app/constants.dart';

modalBottomResidents(context, type, String idUser) {
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
    builder: (context) {
      double currentSliderValue = type;
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 16.0, left: 16.0, right: 16.0, bottom: 32.0),
                        child: Center(
                          child: Text(
                            "Deseja mudar o tipo de usuário?",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kTextColor),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 24, right: 24),
                        child: Slider(
                          value: currentSliderValue,
                          min: 0,
                          max: 4,
                          divisions: 4,
                          label: convertNames(
                              currentSliderValue.round().toString()),
                          onChanged: (double value) {
                            setState(() {
                              currentSliderValue = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Center(
                          child: ElevatedButton(
                            style: style,
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(idUser)
                                  .update({"type": currentSliderValue.round()});
                              Navigator.pop(context);
                            },
                            child: const Text('Salvar'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

String convertNames(String name) {
  switch (name) {
    case "0":
      return "Sem Cadastro";
    case "1":
      return "NAE";
    case "2":
      return "Conselho";
    case "3":
      return "Residente";
    case "4":
      return "Antigo Residente";
    default:
      return "Error!";
  }
}
