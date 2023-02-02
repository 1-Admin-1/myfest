import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PageCalendar extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<PageCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(),
    );
  }
}
