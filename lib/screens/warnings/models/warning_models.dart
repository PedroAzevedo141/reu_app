// import 'package:flutter/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class WarningModels {
//   WarningModels(
//       {required this.title,
//       required this.descricao,
//       required this.user,
//       required this.dateTime});

//   WarningModels.fromJson(Map<String, dynamic> json)
//       : title = json["title"],
//         descricao = json["descricao"],
//         user = json["user"],
//         dateTime = DateTime.parse(json["datetime"]);

//   String title;
//   String descricao;
//   String user;
//   DateTime dateTime;

//   Map<String, dynamic> toJson() {
//     return {
//       "title": title,
//       "descricao": descricao,
//       "user": user,
//       "datetime": dateTime.toIso8601String(),
//     };
//   }
// }

// class AddWarning extends StatelessWidget {
//   final String titulo;
//   final String descricao;
//   final String userID;
//   final String type;
//   final String read;
//   final DateTime dateTime;

//   AddWarning(
//     this.titulo,
//     this.descricao,
//     this.userID,
//     this.type,
//     this.read,
//     this.dateTime,
//   );

//   @override
//   Widget build(BuildContext context) {
//     // Create a CollectionReference called users that references the firestore collection
//     CollectionReference users =
//         FirebaseFirestore.instance.collection('warnings');

//     Future<void> addWarning() {
//       // Call the user's CollectionReference to add a new user
//       return users
//           .add({
//             'title': titulo,
//             'description': descricao,
//             'type_warning': type,
//             'user_ID': userID,
//             'warning_read': read,
//             'dateTime': dateTime.toIso8601String(),
//           })
//           .then((value) => print("Warning Added"))
//           .catchError((error) => print("Failed to add Warning: $error"));
//     }

//     return TextButton(
//       onPressed: addWarning,
//       child: Text(
//         "Add User",
//       ),
//     );
//   }
// }
