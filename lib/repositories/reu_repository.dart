import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/warning_models.dart';

class ReuRepository {
  ReuRepository() {
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }

  late SharedPreferences sharedPreferences;

  void saveWarningList(List<WarningModels> warnings) {
    final jsonString = json.encode(warnings);
    print(jsonString);
  }
}
