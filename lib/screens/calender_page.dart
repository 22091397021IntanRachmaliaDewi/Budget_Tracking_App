import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  // CalendarController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime.now(),
          lastDay: DateTime.now(),
          calendarFormat: CalendarFormat.week,
          calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(color: Colors.orange),
              todayDecoration:
                  BoxDecoration(color: Theme.of(context).primaryColor),
              todayTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white)),
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonDecoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            formatButtonTextStyle: const TextStyle(color: Colors.white),
            formatButtonShowsNext: false,
          ),
          startingDayOfWeek: StartingDayOfWeek.monday,
          // onDaySelected: (date, events) {
          //   print(date.toIso8601String());
          // },
          calendarBuilders: CalendarBuilders(
            prioritizedBuilder: (context, date, events) => Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Text(
                  date.day.toString(),
                  style: const TextStyle(color: Colors.white),
                )),
            todayBuilder: (context, date, events) => Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Text(
                  date.day.toString(),
                  style: const TextStyle(color: Colors.white),
                )),
          ),
          // calendarController: _controller,
        ),
      ),
    );
  }
}
