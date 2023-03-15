import 'package:flutter/material.dart';
import 'package:reu_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        List<Widget> children;
        List<Widget> type0;
        List<Widget> type1;
        List<Widget> type2;
        List<Widget> type3;
        List<Widget> type4;
        if (snapshot.hasError) {
          print("hasError!");
          type0 = <Widget>[
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

          type1 = <Widget>[
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

          type2 = <Widget>[
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

          type3 = <Widget>[
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

          type4 = <Widget>[
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
              type0 = const <Widget>[
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

              type1 = const <Widget>[
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

              type2 = const <Widget>[
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

              type3 = const <Widget>[
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

              type4 = const <Widget>[
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
              type0 = const <Widget>[
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

              type1 = const <Widget>[
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

              type2 = const <Widget>[
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

              type3 = const <Widget>[
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

              type4 = const <Widget>[
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

              type0 = snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                if (data['email'] != null && data['type'] == "0") {
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

              type1 = snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                if (data['email'] != null && data['type'] == "1") {
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
                if (data['email'] != null && data['type'] == "2") {
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

              type3 = snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                if (data['email'] != null && data['type'] == "3") {
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

              type4 = snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                if (data['email'] != null && data['type'] == "4") {
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

              break;
            case ConnectionState.done:
              print("Done!");
              type0 = <Widget>[
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

              type1 = <Widget>[
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

              type2 = <Widget>[
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

              type3 = <Widget>[
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

              type4 = <Widget>[
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
