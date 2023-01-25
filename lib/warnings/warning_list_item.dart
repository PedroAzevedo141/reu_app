import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:reu_app/warnings/models/warning_models.dart';

class WarningListItem extends StatelessWidget {
  WarningModels newWarning;
  final Function(WarningModels) onDelete;

  WarningListItem({
    super.key,
    required this.newWarning,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    String auxUser = newWarning.user;

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
              label: 'Ler',
            ),
            SlidableAction(
              onPressed: (context) {
                onDelete(newWarning);
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
            title: Text(newWarning.title),
            subtitle: Text('Enviado por: $auxUser'),
            children: <Widget>[
              // for (String war in WarningPage.warnings_list)
              ListTile(
                title: Center(
                    child: Text(
                  newWarning.title,
                  style: optionStyle,
                )),
                subtitle: Center(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(newWarning.descricao),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        DateFormat('dd/MMM/yyyy - HH:mm')
                            .format(newWarning.dateTime),
                        style: const TextStyle(fontSize: 8),
                      ),
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
