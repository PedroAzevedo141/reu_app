import 'package:flutter/material.dart';
import 'package:reu_app/constants.dart';
import 'package:reu_app/screens/warnings/models/warning_models.dart';
import 'package:reu_app/screens/warnings/warning_list_item.dart';

import '../../widgets/header_with_seachbox.dart';
import '../../repositories/reu_repository.dart';

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
                    user: data['user_ID'],
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

    // return Stack(
    //   children: <Widget>[
    //     CustomScrollView(
    //       slivers: <Widget>[
    //         const SliverAppBar(
    //           floating: true,
    //           snap: true,
    //           backgroundColor: kPrimaryColor,
    //           elevation: 0.0,
    //           flexibleSpace: FlexibleSpaceBar(
    //             title: Text("Quadro de Avisos"),
    //             centerTitle: true,
    //           ),
    //         ),
    //         SliverToBoxAdapter(
    //           child: HeaderWithSearchBox(size: size),
    //         ),
    //         const SliverToBoxAdapter(
    //           child: Padding(padding: EdgeInsets.all(400)),
    //         ),
    //         // SliverList(
    //         //   delegate: SliverChildListDelegate([
    //         //     for (WarningModels war in warningsList)
    //         //       WarningListItem(
    //         //         newWarning: war,
    //         //         onDelete: onDelete,
    //         //       ),
    //         //   ]),
    //         // ),
    //         // UserInformation(),

    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: children,
    //         ),
    //       ],
    //     )
    //   ],
    // );
  }
}


// class WarningPage extends StatefulWidget {
//   const WarningPage({Key? key}) : super(key: key);

//   @override
//   State<WarningPage> createState() => _WarningPageState();
// }

// class _WarningPageState extends State<WarningPage> {
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

//   final ReuRepository reuRepositoryWarning = ReuRepository();

//   List<WarningModels> warningsList = [];

//   WarningModels? deletedWarning;
//   int? deletedWarningPos;

  // final TextEditingController warningControllerTitle = TextEditingController();
  // final TextEditingController warningControllerDesc = TextEditingController();
  // final TextEditingController warningControllerUser = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     reuRepositoryWarning.getWarningList().then((value) {
//       setState(() {
//         warningsList = value;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Stack(
//       children: <Widget>[
//         CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//               floating: true,
//               snap: true,
//               backgroundColor: kPrimaryColor,
//               elevation: 0.0,
//               flexibleSpace: FlexibleSpaceBar(
//                 title: const Text("Quadro de Avisos"),
//                 centerTitle: true,
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: HeaderWithSearchBox(size: size),
//             ),
//             SliverList(
//               delegate: SliverChildListDelegate([
//                 for (WarningModels war in warningsList)
//                   WarningListItem(
//                     newWarning: war,
//                     onDelete: onDelete,
//                   ),
//               ]),
//             ),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     FloatingActionButton(
//                       onPressed: () {
//                         modalBottom(context);
//                       },
//                       backgroundColor: const Color(0xFF82BB92),
//                       foregroundColor: Colors.white,
//                       child: const Icon(Icons.add),
//                     ),
//                     FloatingActionButton(
//                       onPressed: () {
//                         // modalBottom(context);
//                       },
//                       backgroundColor: const Color(0xFFF0C808),
//                       foregroundColor: Colors.white,
//                       child: const Icon(Icons.done_all),
//                     ),
//                     FloatingActionButton(
//                       onPressed: () {
//                         showDeleteWarningsAfirmationDialog();
//                       },
//                       backgroundColor: const Color(0xFFDD1C1A),
//                       foregroundColor: Colors.white,
//                       child: const Icon(Icons.delete_forever),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }

//   void onDelete(WarningModels war) {
//     deletedWarning = war;
//     deletedWarningPos = warningsList.indexOf(war);

//     setState(() {
//       warningsList.remove(war);
//     });
//     reuRepositoryWarning.saveWarningList(warningsList);

//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(
//         'O aviso ${war.title} foi removido com sucesso!',
//         style: const TextStyle(
//           color: Color(0xff060708),
//         ),
//       ),
//       backgroundColor: const Color(0xffA6E1FA),
//       action: SnackBarAction(
//         label: "Desfazer",
//         textColor: const Color(0xff0E6BA8),
//         onPressed: () {
//           setState(() {
//             warningsList.insert(deletedWarningPos!, deletedWarning!);
//           });
//           reuRepositoryWarning.saveWarningList(warningsList);
//         },
//       ),
//       duration: const Duration(seconds: 5),
//     ));
//   }

//   void showDeleteWarningsAfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Limpar tudo?"),
//         content: const Text("Tem certeza que deseja apagar todos os avisos?"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             style: TextButton.styleFrom(foregroundColor: Colors.black),
//             child: const Text("Cancelar"),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               deleteAllTodos();
//             },
//             style: TextButton.styleFrom(
//               foregroundColor: Colors.red,
//             ),
//             child: const Text('Limpar tudo'),
//           ),
//         ],
//       ),
//     );
//   }

//   void deleteAllTodos() {
//     setState(() {
//       warningsList.clear();
//     });
//     reuRepositoryWarning.saveWarningList(warningsList);
//   }

  // modalBottom(context) {
  //   final ButtonStyle style = ElevatedButton.styleFrom(
  //     elevation: 3,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
  //     minimumSize: const Size(120, 40),
  //     backgroundColor: kButtomColor,
  //   );

  //   return showModalBottomSheet(
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(
  //         top: Radius.circular(25.0),
  //       ),
  //     ),
  //     backgroundColor: Colors.white,
  //     context: context,
  //     builder: (context) => SingleChildScrollView(
  //       child: Container(
  //         padding:
  //             EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
  //         child: Wrap(
  //           children: [
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 const SizedBox(
  //                   height: 20,
  //                 ),
  //                 const Padding(
  //                   padding: EdgeInsets.only(bottom: 24, left: 16, right: 16),
  //                   child: Center(
  //                     child: Text(
  //                       "Insira um novo aviso",
  //                       style: TextStyle(
  //                         fontSize: 26,
  //                         fontWeight: FontWeight.bold,
  //                         fontFamily: 'Raleway',
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding:
  //                       const EdgeInsets.only(bottom: 24, left: 16, right: 16),
  //                   child: TextFormField(
  //                     controller: warningControllerTitle,
  //                     keyboardType: TextInputType.text,
  //                     decoration: const InputDecoration(
  //                       border: OutlineInputBorder(),
  //                       hintText: 'Insira o titulo do aviso',
  //                       labelText: ' Titulo',
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding:
  //                       const EdgeInsets.only(bottom: 24, left: 16, right: 16),
  //                   child: TextFormField(
  //                     controller: warningControllerDesc,
  //                     keyboardType: TextInputType.text,
  //                     decoration: const InputDecoration(
  //                       border: OutlineInputBorder(),
  //                       labelText: 'Detalhes do aviso',
  //                       hintText: ' Insira a descricao do aviso...',
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding:
  //                       const EdgeInsets.only(bottom: 24, left: 16, right: 16),
  //                   child: Center(
  //                     child: ElevatedButton(
  //                       style: style,
  //                       onPressed: () {
  //                         String title = warningControllerTitle.text;
  //                         String desc = warningControllerDesc.text;

  //                         if (title.isEmpty) {
  //                           showDialog(
  //                             context: context,
  //                             builder: (context) => AlertDialog(
  //                               title: const Text("Falta informacoes!"),
  //                               content:
  //                                   const Text("Informe o titulo do aviso..."),
  //                               actions: [
  //                                 TextButton(
  //                                   onPressed: () {
  //                                     Navigator.of(context).pop();
  //                                   },
  //                                   style: TextButton.styleFrom(
  //                                       foregroundColor: Colors.black),
  //                                   child: const Text("Voltar"),
  //                                 ),
  //                               ],
  //                             ),
  //                           );
  //                           return;
  //                         }

  //                         if (desc.isEmpty) {
  //                           showDialog(
  //                             context: context,
  //                             builder: (context) => AlertDialog(
  //                               title: const Text("Falta informacoes!"),
  //                               content: const Text(
  //                                   "Informe a descricao do aviso..."),
  //                               actions: [
  //                                 TextButton(
  //                                   onPressed: () {
  //                                     Navigator.of(context).pop();
  //                                   },
  //                                   style: TextButton.styleFrom(
  //                                       foregroundColor: Colors.black),
  //                                   child: const Text("Voltar"),
  //                                 ),
  //                               ],
  //                             ),
  //                           );
  //                           return;
  //                         }

  //                         setState(() {
  //                           WarningModels newWarning = WarningModels(
  //                             title: title,
  //                             descricao: desc,
  //                             user: "Pedro Azevedo",
  //                             dateTime: DateTime.now(),
  //                           );
  //                           warningsList.add(newWarning);
  //                         });
  //                         reuRepositoryWarning.saveWarningList(warningsList);
  //                         clearController();
  //                         Navigator.pop(context);
  //                       },
  //                       child: const Text(
  //                         'Enviar o aviso',
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

//   void clearController() {
//     warningControllerTitle.clear();
//     warningControllerDesc.clear();
//     warningControllerUser.clear();
//   }
// }