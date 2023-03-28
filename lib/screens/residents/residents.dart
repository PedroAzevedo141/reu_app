import 'package:flutter/material.dart';
import 'package:reu_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reu_app/screens/residents/update_type_residents.dart';

import '../../widgets/header_with_seachbox.dart';

class ResidentsPage extends StatefulWidget {
  const ResidentsPage({Key? key}) : super(key: key);

  @override
  State<ResidentsPage> createState() => _ResidentsPageState();
}

class _ResidentsPageState extends State<ResidentsPage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<Widget> type0;
        List<Widget> type1;
        List<Widget> type2;
        List<Widget> type3;
        List<Widget> type4;
        if (snapshot.hasError) {
          print("hasError!");
          type0 = widgetHasError(snapshot);
          type1 = widgetHasError(snapshot);
          type2 = widgetHasError(snapshot);
          type3 = widgetHasError(snapshot);
          type4 = widgetHasError(snapshot);
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              print("none!");
              type0 = widgetConnectionStateNone();
              type1 = widgetConnectionStateNone();
              type2 = widgetConnectionStateNone();
              type3 = widgetConnectionStateNone();
              type4 = widgetConnectionStateNone();
              break;
            case ConnectionState.waiting:
              print("waiting!");
              type0 = widgetConnectionStateWaiting();
              type1 = widgetConnectionStateWaiting();
              type2 = widgetConnectionStateWaiting();
              type3 = widgetConnectionStateWaiting();
              type4 = widgetConnectionStateWaiting();
              break;
            case ConnectionState.active:
              print("active!");

              type0 = snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                if (data['email'] != null && data['type'] == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 8.0),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: (25),
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset("assets/images/no_user.png"),
                          ),
                        ),
                        title: Text(data['name']),
                        subtitle: Text(data['email']),
                        trailing: InkWell(
                          onTap: () {
                            modalBottomResidents(context, 0.0, document.id);
                          },
                          child: Icon(Icons.settings),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }).toList();

              type1 = snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                if (data['email'] != null && data['type'] == 1) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 8.0),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: (25),
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset("assets/images/no_user.png"),
                          ),
                        ),
                        title: Text(data['name']),
                        subtitle: Text(data['email']),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }).toList();

              type2 = snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                if (data['email'] != null && data['type'] == 2) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 8.0),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: (25),
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset("assets/images/no_user.png"),
                          ),
                        ),
                        title: Text(data['name']),
                        subtitle: Text(data['email']),
                        trailing: InkWell(
                          onTap: () {
                            modalBottomResidents(context, 2.0, document.id);
                          },
                          child: Icon(Icons.settings),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }).toList();

              type3 = snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                if (data['email'] != null && data['type'] == 3) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 8.0),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: (25),
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset("assets/images/no_user.png"),
                          ),
                        ),
                        title: Text(data['name']),
                        subtitle: Text(data['email']),
                        trailing: InkWell(
                          onTap: () {
                            modalBottomResidents(context, 3.0, document.id);
                          },
                          child: Icon(Icons.settings),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }).toList();

              type4 = snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                if (data['email'] != null && data['type'] == 4) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 8.0),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: (25),
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset("assets/images/no_user.png"),
                          ),
                        ),
                        title: Text(data['name']),
                        subtitle: Text(data['email']),
                        trailing: InkWell(
                          onTap: () {
                            modalBottomResidents(context, 4.0, document.id);
                          },
                          child: Icon(Icons.settings),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }).toList();

              break;
            case ConnectionState.done:
              print("Done!");
              type0 = widgetConnectionStateDone(snapshot);
              type1 = widgetConnectionStateDone(snapshot);
              type2 = widgetConnectionStateDone(snapshot);
              type3 = widgetConnectionStateDone(snapshot);
              type4 = widgetConnectionStateDone(snapshot);
              break;
          }
        }

        return Stack(
          children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  snap: true,
                  backgroundColor: kPrimaryColor,
                  elevation: 0.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text("Lista de Residentes"),
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
                      // Lista do NAE
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              const Icon(
                                Icons.groups,
                                color: kTertiaryColor,
                              ),
                              const Text(
                                " NAE",
                                style: TextStyle(
                                  color: kTertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: type1,
                      ),

                      // Lista do Conselho

                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              const Icon(
                                Icons.groups,
                                color: kTertiaryColor,
                              ),
                              const Text(
                                " Conselho",
                                style: TextStyle(
                                  color: kTertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: type2,
                      ),

                      // Lista de Residentes

                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              const Icon(
                                Icons.groups,
                                color: kTertiaryColor,
                              ),
                              const Text(
                                " Residentes",
                                style: TextStyle(
                                  color: kTertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: type3,
                      ),

                      //Lista dos antigos Residentes

                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              const Icon(
                                Icons.groups,
                                color: kTertiaryColor,
                              ),
                              const Text(
                                " Antigos Residentes",
                                style: TextStyle(
                                  color: kTertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: type4,
                      ),

                      // Sem cadastros

                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              const Icon(
                                Icons.groups,
                                color: kTertiaryColor,
                              ),
                              const Text(
                                " Sem cadastro",
                                style: TextStyle(
                                  color: kTertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: type0,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}

List<Widget> widgetHasError(snapshot) {
  return <Widget>[
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
}

List<Widget> widgetConnectionStateNone() {
  return <Widget>[
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
}

List<Widget> widgetConnectionStateWaiting() {
  return <Widget>[
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
}

List<Widget> widgetConnectionStateDone(snapshot) {
  return <Widget>[
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
}
