import 'package:flutter/material.dart';
import 'package:reu_app/constants.dart';
import 'package:reu_app/models/user_model.dart';
import 'package:reu_app/screens/auth_users/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text("Entrar"),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text("CRIAR CONTA"),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
          ),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: ((context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                SizedBox(
                  height: 32.0,
                ),
                CircleAvatar(
                  radius: (100),
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset("assets/images/logo_ufpi.jpg"),
                  ),
                ),
                SizedBox(
                  height: 32.0,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Insira seu e-mail para recuperacao!"),
                          backgroundColor: redAlert,
                          duration: Duration(seconds: 2),
                        ));
                      } else {
                        model.recoverPass(_emailController.text);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Confira seu e-mail!"),
                          backgroundColor: kPrimaryColor,
                          duration: Duration(seconds: 2),
                        ));
                      }
                    },
                    child: Text(
                      "Esqueci minha senha",
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kSecondaryColor),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}

                      model.signIn(
                        email: _emailController.text,
                        pass: _passController.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail,
                      );
                    },
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Falha ao Entrar!"),
      backgroundColor: redAlert,
      duration: Duration(seconds: 2),
    ));
  }
}
