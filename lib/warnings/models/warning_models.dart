import 'package:flutter/widgets.dart';

class WarningModels {
  WarningModels(
      {required this.title,
      required this.descricao,
      required this.user,
      required this.dateTime});

  WarningModels.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        descricao = json["descricao"],
        user = json["user"],
        dateTime = DateTime.parse(json["datetime"]);

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
