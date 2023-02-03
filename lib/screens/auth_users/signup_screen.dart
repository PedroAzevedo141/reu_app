import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
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
              decoration: InputDecoration(
                hintText: "CPF",
              ),
              validator: (text) {
                if (text!.isEmpty || text.length < 6) return "CPF invalido!";
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
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
              decoration: InputDecoration(
                hintText: "Senha",
              ),
              obscureText: true,
              validator: (text) {
                if (text!.isEmpty || text.length < 6) return "Senha invalida!";
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(
              height: 44.0,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
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
      ),
    );
  }
}
