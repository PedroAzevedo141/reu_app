import 'package:flutter/material.dart';
import 'package:reu_app/models/user_model.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;
  UserModel model;

  DrawerTile(this.icon, this.text, this.controller, this.page, this.model);

  @override
  Widget build(BuildContext context) {
    if (this.page == -1) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              model.signOut();
              controller.jumpToPage(0);
            },
            child: Container(
              height: 60.0,
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 32.0,
                    color: controller.page?.round() == page
                        ? Theme.of(context).primaryColor
                        : Colors.grey[700],
                  ),
                  SizedBox(
                    width: 32.0,
                  ),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: controller.page?.round() == page
                            ? Theme.of(context).primaryColor
                            : Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
              controller.jumpToPage(page);
            },
            child: Container(
              height: 60.0,
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 32.0,
                    color: controller.page?.round() == page
                        ? Theme.of(context).primaryColor
                        : Colors.grey[700],
                  ),
                  SizedBox(
                    width: 32.0,
                  ),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: controller.page?.round() == page
                            ? Theme.of(context).primaryColor
                            : Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
