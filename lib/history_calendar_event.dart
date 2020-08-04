part of 'history_calendar_bloc.dart';

abstract class HistoryCalendarEvent extends Equatable {
  const HistoryCalendarEvent();
}

class HistoryCalendarEventSetFilter extends HistoryCalendarEvent {
  final List<int> filter;
  const HistoryCalendarEventSetFilter({@required this.filter});

  @override
  List<Object> get props => [filter];
}

class HistoryCalendarEventSetDateRange extends HistoryCalendarEvent {
  final DateTime startDate;
  final DateTime endDate;
  const HistoryCalendarEventSetDateRange({
    @required this.startDate,
    @required this.endDate,
  });

  @override
  List<Object> get props => [startDate, endDate];
}

class HistoryCalendarEventSelectDate extends HistoryCalendarEvent {
  final DateTime selectedDate;
  const HistoryCalendarEventSelectDate({@required this.selectedDate});

  @override
  List<Object> get props => [selectedDate];
}
