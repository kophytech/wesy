import 'package:cs_repository/cs_repository.dart';
import 'package:cs_ui/cs_ui.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PlanDataSource extends CalendarDataSource {
  PlanDataSource(List<Schedule> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(appointments![index].startDate.toString());
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.parse(appointments![index].endDate.toString());
  }

  @override
  String getSubject(int index) {
    return appointments![index].title.toString();
  }

  @override
  Color getColor(int index) {
    return CsColors.primary;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].allDay as bool;
  }
}
