import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'history_calendar_event.dart';
part 'history_calendar_state.dart';

class _Activities {
  final List<int> activities;
  final DateTime selectedDate;
  List<int> get agendaActivities {
    return selectedDate != null
        ? activities : [];
  }

  Future<List<int>> getPlantsForActivities() {
    final List<int> plantIds = agendaActivities;
    return Future.value(plantIds);
  }

  const _Activities({this.activities, this.selectedDate});
}

class HistoryCalendarBloc
    extends Bloc<HistoryCalendarEvent, HistoryCalendarState> {
  HistoryCalendarBloc();

  @override
  Stream<HistoryCalendarState> mapEventToState(
    HistoryCalendarEvent event,
  ) async* {
    if (event is HistoryCalendarEventSetFilter) {
      yield HistoryCalendarStateIsLoading(
        filter: event.filter,
        startDate: state.startDate,
        endDate: state.endDate,
        selectedDate: state.selectedDate,
        activities: state.activities,
        agendaActivities: state.agendaActivities,
        plants: state.plants,
      );

      yield HistoryCalendarStateSet(
        activities: state.activities,
        filter: state.filter,
        startDate: state.startDate,
        endDate: state.endDate,
        selectedDate: state.selectedDate,
        agendaActivities: state.agendaActivities,
        plants: state.plants,
      );
    }
    if (event is HistoryCalendarEventSetDateRange) {
      yield HistoryCalendarStateIsLoading(
        filter: state.filter,
        startDate: event.startDate,
        endDate: event.endDate,
        selectedDate: state.selectedDate,
        activities: state.activities,
        agendaActivities: state.agendaActivities,
        plants: state.plants,
      );

      yield HistoryCalendarStateSet(
        activities: state.activities,
        filter: state.filter,
        startDate: state.startDate,
        endDate: state.endDate,
        agendaActivities: state.agendaActivities,
        selectedDate: state.selectedDate,
        plants: state.plants,
      );
    }
    if (event is HistoryCalendarEventSelectDate) {
      yield HistoryCalendarStateIsLoading(
        filter: state.filter,
        startDate: state.startDate,
        endDate: state.endDate,
        selectedDate: event.selectedDate,
        activities: state.activities,
        agendaActivities: state.agendaActivities,
        plants: state.plants,
      );

      final _Activities activities = _Activities(
          activities: state.activities, selectedDate: state.selectedDate);

      yield HistoryCalendarStateSet(
        activities: activities.activities,
        plants: state.plants,
        filter: state.filter,
        startDate: state.startDate,
        endDate: state.endDate,
        agendaActivities: activities.agendaActivities,
        selectedDate: state.selectedDate,
      );
    }
  }

  @override
  HistoryCalendarState get initialState => HistoryCalendarStateInitial();
}
