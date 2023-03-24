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
      double _currentSliderValue = 20;
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
                      Padding(
                        padding: const EdgeInsets.only(
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
                      Slider(
                        value: _currentSliderValue,
                        max: 100,
                        divisions: 5,
                        label: _currentSliderValue.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderValue = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 200,
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

// Future<void> dialogBuilder(BuildContext context, int i, String id) {
//   if (i == 0) {
//     String buttom1 = "Para NAE";
//     String buttom2 = "Para Residente";
//   } else if (i == 2) {
//     String buttom1 = "Antigo Residente";
//     String buttom2 = "Para Residente";
//   } else if (i == 3) {
//     String buttom1 = "Antigo Residente";
//     String buttom2 = "Para Conselho";
//   } else if (i == 4) {
//     String buttom1 = "Sem Cadastro";
//     String buttom2 = "Para Residente";
//   }
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Deseja mudar o tipo de cadastro do usuário?'),
//         content: const Text(
//             'Ao alterar o tipo de cadastro, o processo poderá ser alterado.\n'
//             'Deseja continuar?'),
//         actions: <Widget>[
//           ElevatedButton(
//             style: TextButton.styleFrom(
//               backgroundColor: redAlert,
//               textStyle: Theme.of(context).textTheme.labelLarge,
//             ),
//             child: const Text('Cancelar'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           ElevatedButton(
//             style: TextButton.styleFrom(
//               backgroundColor: kQuaternaryColor,
//               textStyle: Theme.of(context).textTheme.labelLarge,
//             ),
//             child: const Text(buttom1),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           ElevatedButton(
//             style: TextButton.styleFrom(
//               backgroundColor: kButtomColor,
//               textStyle: Theme.of(context).textTheme.labelLarge,
//             ),
//             child: const Text('Enable'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
