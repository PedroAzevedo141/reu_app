import 'package:flutter/material.dart';
import 'package:reu_app/constants.dart';
import 'package:reu_app/tiles/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  const CustomDrawer({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 4),
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                  height: 170.0,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8.0,
                        left: 0.0,
                        child: Text(
                          "REU\nApplication",
                          style: TextStyle(
                              fontSize: 34.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ola, ",
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              child: Text(
                                "Entre ou cadastre-se >",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                              onTap: (() {}),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                DrawerTile(Icons.home, "Inicio", pageController, 0),
                DrawerTile(Icons.poll, "Enquetes", pageController, 1),
                DrawerTile(
                    Icons.warning, "Quadro de Avisos", pageController, 2),
                DrawerTile(
                    Icons.groups, "Lista de Residentes", pageController, 3),
                DrawerTile(Icons.calendar_month, "Calendario de Atividades",
                    pageController, 4),
              ],
            )
          ],
        ),
      ),
    );
  }
}
