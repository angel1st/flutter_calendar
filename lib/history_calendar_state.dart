part of 'history_calendar_bloc.dart';

abstract class HistoryCalendarState extends Equatable {
  final List<int> filter;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime selectedDate;
  final List<int> activities;
  final List<dynamic> agendaActivities;
  final List<int> plants;
  const HistoryCalendarState({
    @required this.filter,
    @required this.startDate,
    @required this.endDate,
    @required this.selectedDate,
    @required this.activities,
    @required this.agendaActivities,
    @required this.plants,
  });
}

class HistoryCalendarStateInitial extends HistoryCalendarState {
  HistoryCalendarStateInitial()
      : super(
          filter: [0,1],
          startDate: DateTime.now(),
          endDate: DateTime.now().add(
            const Duration(days: 1),
          ),
          selectedDate: DateTime.now(),
          activities: [],
          agendaActivities: [],
    plants: [],
        );
  @override
  List<Object> get props => [];
}

class HistoryCalendarStateIsLoading extends HistoryCalendarState {
  const HistoryCalendarStateIsLoading({
    @required List<int> filter,
    @required DateTime startDate,
    @required DateTime endDate,
    @required DateTime selectedDate,
    @required List<int> activities,
    @required agendaActivities,
    @required plants,
  }) : super(
          filter: filter,
          startDate: startDate,
          endDate: endDate,
          selectedDate: selectedDate,
          activities: activities,
          agendaActivities: agendaActivities,
    plants: plants,
        );
  @override
  List<Object> get props => [];
}

class HistoryCalendarStateSet extends HistoryCalendarState {
  final List<int> activities;
  const HistoryCalendarStateSet({
    @required this.activities,
    @required List<int> filter,
    @required DateTime startDate,
    @required DateTime endDate,
    @required DateTime selectedDate,
    @required List<dynamic> agendaActivities,
    @required List<int> plants,
  }) : super(
          filter: filter,
          startDate: startDate,
          endDate: endDate,
          selectedDate: selectedDate,
          activities: activities,
          agendaActivities: agendaActivities,
    plants: plants,
        );
  @override
  List<Object> get props => [activities];
}