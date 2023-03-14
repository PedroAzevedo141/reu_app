// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// import '../screens/warnings/models/warning_models.dart';

// const warningListKey = "warning_list";

// class ReuRepository {
//   late SharedPreferences sharedPreferences;

//   Future<List<WarningModels>> getWarningList() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     final String jsonString =
//         sharedPreferences.getString(warningListKey) ?? '[]';
//     final List jsonDecoded = json.decode(jsonString) as List;
//     return jsonDecoded.map((e) => WarningModels.fromJson(e)).toList();
//   }

//   void saveWarningList(List<WarningModels> warnings) {
//     final String jsonString = json.encode(warnings);
//     sharedPreferences.setString(warningListKey, jsonString);
//   }
// }
