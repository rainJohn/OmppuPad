import 'dart:async';

import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';

/*
  A somewhat generic Bloc for discrete time streams (every second, minute and day, respectively).
  NOTE: This particular stream is snapshot (time should be linear and synced, hence we use 
  a periodic stream to 'tick' every second).
*/
class TimeBloc {
  static final DateFormat _hourFormat = DateFormat('HH:mm');
  static final DateFormat _secondsFormat = DateFormat('ss');
  static final DateFormat _dateFormat = DateFormat('EEEE, dd MMMM yyyy');

  static final _timeController = Stream.periodic(Duration(seconds: 1));
  static final _hourAndMinutes = BehaviorSubject<String>(seedValue: _hourFormat.format(_timeSnapshot));
  static final _seconds = BehaviorSubject<String>(seedValue: _secondsFormat.format(_timeSnapshot));
  static final _date = BehaviorSubject<String>(seedValue: _dateFormat.format(_timeSnapshot));

  static final TimeBloc _singleton = TimeBloc._internal();

  factory TimeBloc() {
    return _singleton;
  }

  static DateTime _timeSnapshot = DateTime.now();

  // TODO investigate splitting into several listeners for minute/date
  TimeBloc._internal() {
    _timeController.listen((_) {
      _seconds.sink.add(_secondsFormat.format(DateTime.now()));
      var nowHour = _hourFormat.format(DateTime.now());
      if (_hourFormat.format(_timeSnapshot) != nowHour) {
        _hourAndMinutes.sink.add(nowHour);
      }
      var nowDate = _dateFormat.format(DateTime.now());
      if (_dateFormat.format(_timeSnapshot) != nowDate) {
        _date.sink.add(nowDate);
      }
      _timeSnapshot = DateTime.now(); // mitigate clockdrift (somewhat)
    });
  }

  Stream<String> get hourAndMinutes => _hourAndMinutes.stream;
  Stream<String> get seconds => _seconds.stream;
  Stream<String> get date => _date.stream;

  void dispose() {
    _hourAndMinutes.close();
    _seconds.close();
    _date.close();
  }


}