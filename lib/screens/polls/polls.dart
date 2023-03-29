import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reu_app/constants.dart';

import '../../widgets/header_with_seachbox.dart';

import 'package:simple_polls/simple_polls.dart';

class PoolPage extends StatefulWidget {
  const PoolPage({Key? key}) : super(key: key);

  @override
  State<PoolPage> createState() => _PoolPageState();
}

class _PoolPageState extends State<PoolPage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('polls')
      .orderBy('dateTime', descending: false)
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
                if (data['title'] != null) {
                  return SimplePollsWidget(
                    /// onSelection will be triggered when users presses a option or presses undo button(only available on editable polls).
                    /// This function will be called after all the calculation like reducing total polls and marking previous option not selected.
                    /// It returns the PollFrameModel .Use this function to do some extra operations like storing this poll into other variable.
                    onSelection: (PollFrameModel model,
                        PollOptions? selectedOptionModel) {
                      print("1");
                      if (selectedOptionModel!.id == 1) {
                        updateUser(document.id, data, "awenser1_count", 1);
                      } else if (selectedOptionModel.id == 2) {
                        updateUser(document.id, data, "awenser2_count", 2);
                      } else if (selectedOptionModel.id == 3) {
                        updateUser(document.id, data, "awenser3_count", 3);
                      } else {
                        print("error");
                      }
                    },
                    onReset: (PollFrameModel model) {
                      print(model);
                      print(model.options[0].isSelected);
                      print(model.options[1].isSelected);
                      print(model.options[2].isSelected);
                      print(
                          'Poll has been reset, this happens only in case of editable polls');
                    },
                    optionsBorderShape:
                        const StadiumBorder(), // Default is stadium border

                    /// optionsStyle will have style used in options.
                    optionsStyle: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),

                    /// languageCode will be used to translate some text used in status like total polls, Poll end time, Undo button.
                    /// Allowed values are it,fr,es,gr,en where en is default.
                    /// For more language support add translations for that language code in translations/translations.dart and widgets/poll_status.dart.
                    /// Add timeago.setLocaleMessages('it', timeago.ItMessages()); to register locales for timeago/remaining in widgets/poll_status.dart.
                    /// Add 'es': 'deshacer' to maps present in translations/translations.dart for other translations.
                    languageCode: 'en',

                    /// Content Padding inside polls widget.
                    padding: const EdgeInsets.all(15),

                    /// Margin for polls widget.
                    margin: const EdgeInsets.all(15),

                    /// Data to be passed to polls widget.
                    model: PollFrameModel(
                      /// Title of the widget.
                      title: Container(
                        alignment: Alignment.center,
                        child: Text(
                          data['title'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      totalPolls: data['awenser1_count'] +
                          data['awenser2_count'] +
                          data['awenser3_count'],

                      /// Poll end time
                      endTime: DateTime.parse(data['dateTime'])
                          .add(Duration(days: 7)),

                      /// If user hasVoted then results screen will show up.
                      hasVoted: currentUserUID(data['userVoted']),

                      /// If poll is editable then undo button will appear in results screen to participate in poll again.
                      editablePoll: false,
                      options: <PollOptions>[
                        /// Configure options here
                        PollOptions(
                          label: data['awenser1'],
                          pollsCount: data['awenser1_count'],

                          /// Polls received by that option.
                          isSelected: data['isSelected'] == 1,

                          /// If poll selected.
                          id: 1,

                          /// Option id.
                        ),
                        PollOptions(
                          label: data['awenser2'],
                          pollsCount: data['awenser2_count'],
                          isSelected: data['isSelected'] == 2,
                          id: 2,
                        ),
                        PollOptions(
                          label: data['awenser3'],
                          pollsCount: data['awenser3_count'],
                          isSelected: data['isSelected'] == 3,
                          id: 3,
                        ),
                      ],
                    ),
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
                SliverAppBar(
                  floating: true,
                  snap: true,
                  backgroundColor: kPrimaryColor,
                  elevation: 0.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text("Enquetes"),
                    centerTitle: true,
                  ),
                ),
                SliverToBoxAdapter(
                  child: HeaderWithSearchBox(size: size),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(children),
                ),
                SliverToBoxAdapter(
                  child: const Padding(padding: EdgeInsets.all(400)),
                )
              ],
            )
          ],
        );
      },
    );
  }

  bool currentUserUID(data) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? firebaseUser = _auth.currentUser;
    return data.contains(firebaseUser?.uid);
  }
}

Future<void> updateUser(id, data, type, int itemSelected) async {
  Map<String, dynamic> userData = {};
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? firebaseUser = _auth.currentUser;
  if (firebaseUser != null) {
    DocumentSnapshot docUser = await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .get();
    userData = docUser.data() as Map<String, dynamic>;

    CollectionReference pollsUpdate =
        FirebaseFirestore.instance.collection('polls');

    return pollsUpdate
        .doc(id)
        .update({
          'userVoted': FieldValue.arrayUnion([firebaseUser.uid]),
          type: data[type] + 1,
          'isSelected': itemSelected,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}

Future<void> removeUser(id, data, type) async {
  Map<String, dynamic> userData = {};
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? firebaseUser = _auth.currentUser;
  if (firebaseUser != null) {
    DocumentSnapshot docUser = await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .get();
    userData = docUser.data() as Map<String, dynamic>;

    CollectionReference pollsUpdate =
        FirebaseFirestore.instance.collection('polls');

    if (data["userVoted"].contains(firebaseUser.uid) == true) {
      return pollsUpdate
          .doc(id)
          .update({
            'userVoted': FieldValue.arrayRemove([firebaseUser.uid]),
            type: data[type] - 1
          })
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    }
  }
}
