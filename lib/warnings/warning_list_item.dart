import 'package:flutter/material.dart';

class WarningListItem extends StatelessWidget {
  Map message;

  WarningListItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    EdgeInsets marginCards = const EdgeInsets.only(bottom: 25);
    String auxUser = message['user'];

    const TextStyle optionStyle =
        TextStyle(fontSize: 21, fontWeight: FontWeight.bold);

    return Card(
      elevation: 5,
      margin: marginCards,
      child: ExpansionTile(
        title: Text(message['title']),
        subtitle: Text('Enviado por: $auxUser'),
        children: <Widget>[
          // for (String war in WarningPage.warnings_list)
          ListTile(
            title: Center(
                child: Text(
              message['title'],
              style: optionStyle,
            )),
            subtitle: Center(child: Text(message['desc'])),
            leading: const Icon(
              Icons.person,
              size: 56,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
