import 'package:flutter/widgets.dart';

class WarningModels extends ChangeNotifier {
  WarningModels(
      {required this.title,
      required this.descricao,
      required this.user,
      required this.dateTime});

  String title;
  String descricao;
  String user;
  DateTime dateTime;

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "descricao": descricao,
      "user": user,
      "datetime": dateTime.toIso8601String(),
    };
  }
}
