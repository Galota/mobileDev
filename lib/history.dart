import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';



class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Histórico',
          textAlign: TextAlign.center,
        ),
      ),
      body: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 0,
      )
    );
  }
}