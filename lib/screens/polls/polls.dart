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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
            SliverToBoxAdapter(
              child: SimplePollsWidget(
                /// onSelection will be triggered when users presses a option or presses undo button(only available on editable polls).
                /// This function will be called after all the calculation like reducing total polls and marking previous option not selected.
                /// It returns the PollFrameModel .Use this function to do some extra operations like storing this poll into other variable.
                onSelection:
                    (PollFrameModel model, PollOptions? selectedOptionModel) {
                  print('Now total polls are : ${model.totalPolls}');
                  print(
                      'Selected option has label : ${selectedOptionModel!.label}');
                },
                onReset: (PollFrameModel model) {
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
                languageCode: 'es',

                /// Content Padding inside polls widget.
                padding: const EdgeInsets.all(15),

                /// Margin for polls widget.
                margin: const EdgeInsets.all(15),

                /// Data to be passed to polls widget.
                model: PollFrameModel(
                  /// Title of the widget.
                  title: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Questo è il titolo del sondaggio. Questo è il titolo del sondaggio. Questo è il titolo del sondaggio.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  totalPolls: 100,

                  /// Poll end time
                  endTime: DateTime.now().toUtc().add(const Duration(days: 10)),

                  /// If user hasVoted then results screen will show up.
                  hasVoted: false,

                  /// If poll is editable then undo button will appear in results screen to participate in poll again.
                  editablePoll: true,
                  options: <PollOptions>[
                    /// Configure options here
                    PollOptions(
                      label: "opzione 1",
                      pollsCount: 40,

                      /// Polls received by that option.
                      isSelected: false,

                      /// If poll selected.
                      id: 1,

                      /// Option id.
                    ),
                    PollOptions(
                      label: "opzione 2",
                      pollsCount: 25,
                      isSelected: false,
                      id: 2,
                    ),
                    PollOptions(
                      label: "opzione 3",
                      pollsCount: 35,
                      isSelected: false,
                      id: 3,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: const Padding(padding: EdgeInsets.all(400)),
            )
          ],
        )
      ],
    );
  }
}
