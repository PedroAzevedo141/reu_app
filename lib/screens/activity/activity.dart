import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reu_app/constants.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/header_with_seachbox.dart';
import 'utils.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  late List<Event> _selectedEvents;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = [];
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('events').snapshots();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<Widget> children;
        var kEvents;
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
          kEvents = [];
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
              kEvents = [];
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
              kEvents = [];
              break;
            case ConnectionState.active:
              print("active!");
              var kEventsFire =
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                return {
                  DateTime.utc(
                          document['date'].toDate().year,
                          document['date'].toDate().month,
                          document['date'].toDate().day):
                      List.generate(1, (index) => Event(document['title']))
                };
              }).toList();

              Map<DateTime, List<Event>> combinedMap = {};
              for (var item in kEventsFire) {
                for (var entry in item.entries) {
                  combinedMap
                      .putIfAbsent(entry.key, () => [])
                      .addAll(entry.value);
                }
              }

              kEvents = LinkedHashMap<DateTime, List<Event>>(
                equals: isSameDay,
                hashCode: getHashCode,
              )..addAll(combinedMap);

              print("-=-=-=-=-=-=-=-");
              // print(lenghtList);
              print(kEventsFire);
              print(combinedMap);
              // print(kEvents.runtimeType);
              print("-=-=-=-=-=-=-=-");
              children = [];
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
              kEvents = [];
              break;
          }
        }

        // print("Final!");
        // print(kEvents);

        List<Event> getEventsForDay(DateTime day) {
          // Implementation example
          // print("-=-=-=-=-=-=-=-=-");
          // print(kEvents);
          // print(day);
          // print(kEvents[day] ?? []);
          // print("-=-=-=-=-=-=-=-=-");
          List<Event> events = [];
          kEvents.forEach((chaveMap, valorMap) {
            if (chaveMap == day) {
              // print(chaveMap);
              // print(valorMap);
              events.addAll(valorMap);
            }
          });

          return events;
        }

        getEventsForRange(DateTime start, DateTime end) {
          // Implementation example
          final days = daysInRange(start, end);

          return [
            for (final d in days) ...getEventsForDay(d),
          ];
        }

        void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              _rangeStart = null; // Important to clean those
              _rangeEnd = null;
              _rangeSelectionMode = RangeSelectionMode.toggledOff;
            });

            print(">>>>>>>>>>>> Cheguei no _selectedEvents");
            _selectedEvents = getEventsForDay(selectedDay);
            print(_selectedEvents);
            print(">>>>>>>>>>>> Sair do _selectedEvents");
          }
        }

        void onRangeSelected(
            DateTime? start, DateTime? end, DateTime focusedDay) {
          setState(() {
            _selectedDay = null;
            _focusedDay = focusedDay;
            _rangeStart = start;
            _rangeEnd = end;
            _rangeSelectionMode = RangeSelectionMode.toggledOn;
          });

          // `start` or `end` could be null
          if (start != null && end != null) {
            _selectedEvents = getEventsForRange(start, end);
          } else if (start != null) {
            _selectedEvents = getEventsForDay(start);
          } else if (end != null) {
            _selectedEvents = getEventsForDay(end);
          }
        }

        if (children.isNotEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
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
                      title: Text("Calendario de Atividades"),
                      centerTitle: true,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: HeaderWithSearchBox(size: size),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 16),
                      child: TableCalendar(
                        locale: 'pt_BR',
                        firstDay: kFirstDay,
                        lastDay: kLastDay,
                        focusedDay: _focusedDay,
                        eventLoader: getEventsForDay,
                        onDaySelected: onDaySelected,
                        onRangeSelected: onRangeSelected,
                        calendarFormat: _calendarFormat,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 32, right: 32, bottom: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          _addEvent(context, _selectedDay);
                        },
                        child: Text("Add Event"),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      SingleChildScrollView(
                        child: Column(
                          children: _selectedEvents
                              .map((item) => Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 8.0,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: ListTile(
                                      onTap: () => print('$item'),
                                      title: Text('$item'),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ]),
                  ),
                ],
              )
            ],
          );
        }
      },
    );
  }
}

Future<void> _addEvent(BuildContext context, _selectedDay) async {
  final TextEditingController _eventController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Add Event"),
        content: TextField(
          controller: _eventController,
          decoration: InputDecoration(
            hintText: "Enter event title",
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              String eventTitle = _eventController.text.trim();
              if (eventTitle.isNotEmpty) {
                await _saveEvent(eventTitle, _selectedDay);
              }
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      );
    },
  );
}

Future<void> _saveEvent(String eventTitle, DateTime selectedDay) async {
  final eventsRef = FirebaseFirestore.instance.collection('events');
  final selectedDate =
      DateTime.utc(selectedDay.year, selectedDay.month, selectedDay.day + 1);
  final newEvent = {
    'title': eventTitle,
    'date': Timestamp.fromDate(selectedDate)
  };
  await eventsRef.add(newEvent);
  print("Event '$eventTitle' saved for $selectedDay");
}
