import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'history_calendar_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SyncfusionLicense.registerLicense(
      'put-your-code');
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HistoryCalendarBloc>(
      create: (context) => HistoryCalendarBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
           primarySwatch: Colors.blue,
           visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HistoryCalendarBloc historyCalendarBloc =
        BlocProvider.of<HistoryCalendarBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<HistoryCalendarBloc, HistoryCalendarState>(
        condition: (_, historyCalendarState) =>
            historyCalendarState is HistoryCalendarStateSet ||
            historyCalendarState is HistoryCalendarStateIsLoading,
        builder: (context, historyCalendarState) => LoadingOverlay(
          isLoading: historyCalendarState is HistoryCalendarStateIsLoading,
          child: SfCalendar(
            controller: _calendarController,
            maxDate: DateTime.now(),
            //minDate: DateTime.now().subtract(const Duration(days: 30)),
            firstDayOfWeek:
                MaterialLocalizations.of(context).firstDayOfWeekIndex,
            view: CalendarView.month,
            onViewChanged: (ViewChangedDetails viewChangedDetails) {
              historyCalendarBloc.add(
                HistoryCalendarEventSetDateRange(
                  startDate: viewChangedDetails.visibleDates.first,
                  endDate: viewChangedDetails.visibleDates.last
                      .add(const Duration(days: 1)),
                ),
              );
            },
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
