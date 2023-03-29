import 'package:flutter/material.dart';
import 'package:reu_app/constants.dart';
import 'package:reu_app/screens/warnings/warning_list_item.dart';
import '../../widgets/header_with_seachbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WarningPage extends StatefulWidget {
  const WarningPage(
      TextEditingController warningControllerTitle,
      TextEditingController warningControllerDesc,
      TextEditingController warningControllerUser,
      {Key? key})
      : super(key: key);

  @override
  State<WarningPage> createState() => _WarningPageState();
}

class _WarningPageState extends State<WarningPage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('warnings')
      .orderBy('dateTime', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<Widget> children;
        if (snapshot.hasError) {
          print("hasError!");
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('Stack trace: ${snapshot.stackTrace}'),
            ),
          ];
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              print("none!");
              children = const <Widget>[
                Icon(
                  Icons.info,
                  color: Colors.blue,
                  size: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Select a lot'),
                ),
              ];
              break;
            case ConnectionState.waiting:
              print("waiting!");
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting bids...'),
                ),
              ];
              break;
            case ConnectionState.active:
              print("active!");
              children = snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                print("-=-=-=-=-=-=-=-=-");
                print("data: $data");
                print(document.id);
                print("-=-=-=-=-=-=-=-=-");
                if (data['title'] != null) {
                  return WarningListItem(
                    title: data['title'],
                    descricao: data['description'],
                    dateTime: data['dateTime'],
                    user: data['user_Name'],
                    id_warning: document.id,
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top: 16),
                  );
                }
              }).toList();
              break;
            case ConnectionState.done:
              print("Done!");
              children = <Widget>[
                const Icon(
                  Icons.info,
                  color: Colors.blue,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('\$${snapshot.data} (closed)'),
                ),
              ];
              break;
          }
        }

        print("Final!");

        return Stack(
          children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[
                const SliverAppBar(
                  floating: true,
                  snap: true,
                  backgroundColor: kPrimaryColor,
                  elevation: 0.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text("Quadro de Avisos"),
                    centerTitle: true,
                  ),
                ),
                SliverToBoxAdapter(
                  child: HeaderWithSearchBox(size: size),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 15.0, bottom: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.filter_list,
                                color: kTertiaryColor,
                              ),
                              const Text(
                                "Filtros",
                                style: TextStyle(
                                  color: kTertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(children),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
