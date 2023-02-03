import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reu_app/constants.dart';
import 'package:reu_app/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );

            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Nome Completo",
                    ),
                    validator: (text) {
                      if (text!.isEmpty) return "Nome invalido!";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _cpfController,
                    decoration: InputDecoration(
                      hintText: "CPF",
                    ),
                    validator: (text) {
                      if (text!.isEmpty || text.length < 6)
                        return "CPF invalido!";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text!.isEmpty || !text.contains("@"))
                        return "E-mail invalido!";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                      hintText: "Senha",
                    ),
                    obscureText: true,
                    validator: (text) {
                      if (text!.isEmpty || text.length < 6)
                        return "Senha invalida!";
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: 44.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> userData = {
                            "name": _nameController.text,
                            "cpf": _cpfController.text,
                            "email": _emailController.text,
                          };

                          model.signUp(
                            userData: userData,
                            pass: _passController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail,
                          );
                        }
                      },
                      child: Text(
                        'Criar Conta',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  void _onSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Usuario criado com sucesso!"),
      backgroundColor: kTertiaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Falha ao criar o usuario!"),
      backgroundColor: redAlert,
      duration: Duration(seconds: 2),
    ));
  }
}
