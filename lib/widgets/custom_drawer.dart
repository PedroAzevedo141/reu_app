import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reu_app/constants.dart';
import 'package:reu_app/models/user_model.dart';
import 'package:reu_app/screens/auth_users/login_screen.dart';
import 'package:reu_app/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  const CustomDrawer({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoggedIn()) {
              return ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text("Residência Universitária"),
                    accountEmail: Text("${model.userData["email"]}"),
                    currentAccountPicture: CircleAvatar(
                        radius: (50),
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset("assets/images/logo_ufpi.jpg"),
                        )),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [kPrimaryColor, kTertiaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                    ),
                  ),
                  DrawerTile(Icons.home, "Inicio", pageController, 0, model),
                  DrawerTile(Icons.poll, "Enquetes", pageController, 1, model),
                  DrawerTile(Icons.warning, "Quadro de Avisos", pageController,
                      2, model),
                  DrawerTile(Icons.groups, "Lista de Residentes",
                      pageController, 3, model),
                  DrawerTile(Icons.calendar_month, "Calendario de Atividades",
                      pageController, 4, model),
                  DrawerTile(Icons.logout, "Sair", pageController, -1, model),
                ],
              );
            } else {
              return ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text("Residência Universitária"),
                    accountEmail: Text("sundar@appmaking.co"),
                    currentAccountPicture: CircleAvatar(
                        radius: (50),
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset("assets/images/logo_ufpi.jpg"),
                        )),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [kPrimaryColor, kTertiaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.login,
                      size: 32.0,
                    ),
                    title: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[700],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
