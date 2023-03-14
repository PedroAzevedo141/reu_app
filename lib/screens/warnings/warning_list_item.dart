import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WarningListItem extends StatelessWidget {
  final String title, descricao, dateTime, user, id_warning;

  WarningListItem({
    super.key,
    required this.title,
    required this.descricao,
    required this.dateTime,
    required this.user,
    required this.id_warning,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle optionStyle =
        TextStyle(fontSize: 21, fontWeight: FontWeight.bold);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            const SlidableAction(
              // An action can be bigger than the others.
              onPressed: null,
              backgroundColor: Color(0xFFF0C808),
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              icon: Icons.done,
              label: 'Lida',
            ),
            SlidableAction(
              onPressed: (context) {
                CollectionReference users =
                    FirebaseFirestore.instance.collection('warnings');

                users
                    .doc(id_warning)
                    .delete()
                    .then((value) => print("User Deleted"))
                    .catchError(
                        (error) => print("Failed to delete user: $error"));
              },
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              backgroundColor: const Color(0xFFDD1C1A),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Deletar',
            ),
          ],
        ),
        // The end action pane is the one at the right or the bottom side.
        child: Card(
          elevation: 3,
          // margin: marginCards,
          child: ExpansionTile(
            title: Text(title),
            subtitle: Text('Enviado por: $user'),
            children: <Widget>[
              // for (String war in WarningPage.warnings_list)
              ListTile(
                title: Center(
                    child: Text(
                  title,
                  style: optionStyle,
                )),
                subtitle: Center(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(descricao),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      // child: Text(
                      //   DateFormat('dd/MMM/yyyy - HH:mm')
                      //       .format(dateTime as DateTime),
                      //   style: const TextStyle(fontSize: 8),
                      child:
                          Text(dateTime, style: const TextStyle(fontSize: 8)),
                    ),
                  ],
                )),
                leading: const Icon(
                  Icons.person,
                  size: 56,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
