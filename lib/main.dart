import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reu_app/models/user_model.dart';
import 'package:reu_app/screens/home_page_controller.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  // try {
  //   UserCredential userCredential = await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(
  //           email: "pedroazevedo141@gmail.com", password: "123456");
  //   print(userCredential);
  // } on FirebaseAuthException catch (e) {
  //   if (e.code == 'user-not-found') {
  //     print('No user found for that email.');
  //   } else if (e.code == 'wrong-password') {
  //     print('Wrong password provided for that user.');
  //   }
  // }
  // print('-=-=-=-=-=-=-=-=-=-=-');

  // //code example flutter firebase auth emulator

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);

  // try {
  //   UserCredential userCredential = await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: "email", password: "password");
  //   print(userCredential);
  // } on FirebaseAuthException catch (e) {
  //   if (e.code == 'user-not-found') {
  //     print('No user found for that email.');
  //   } else if (e.code == 'wrong-password') {
  //     print('Wrong password provided for that user.');
  //   }
  // }

  // // now read and write to the database
  // FirebaseFirestore.instance.collection('users').add({'name': 'John Doe'});
  // // now read the inserted data
  // FirebaseFirestore.instance.collection('users').get().then((value) {
  //   value.docs.forEach((element) {
  //     print(element.data());
  //   });
  // });

  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Aplicativo da Residencia Universitaria';

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: _title,
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 4, 125, 141),
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePageController(),
      ),
    );
  }
}
