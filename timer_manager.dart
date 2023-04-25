import 'dart:async';

typedef TimerBlock = void Function();

class TimerManager {
  Map<String, int?> _hashSource = {};
  Map<int, Timer?> _timerSource = {};
  Map<int, TimerBlock?> _eventSource = {};

  factory TimerManager() {
    return instance;
  }

  TimerManager._internal();

  static final TimerManager instance = TimerManager._internal();

  bool startTimer(String key, int duration, {TimerBlock? asyncBloc}) {
    int? hashCode = _hashSource[key];
    if (hashCode != null) {
      return false;
    }
    Timer timer = Timer.periodic(Duration(seconds: duration), (v) {
      if (_eventSource[v.hashCode] != null) {
        _eventSource[v.hashCode]!();
      }
    });
    _hashSource[key] = timer.hashCode;
    _timerSource[timer.hashCode] = timer;
    _eventSource[timer.hashCode] = asyncBloc;
    return true;
  }

  void cancelTimer(String key) {
    int? hashCode = _hashSource[key];
    if (hashCode != null) {
      Timer? timer = _timerSource[hashCode];
      if (timer != null) {
        timer.cancel();
        _timerSource[hashCode] = null;
      }
      TimerBlock? event = _eventSource[hashCode];
      if (event != null) {
        _eventSource[hashCode] = null;
      }
      _hashSource[key] = null;
    }
  }

  void cancelAllTimer() {
    for (var element in _hashSource.keys) {
      cancelTimer(element);
    }
    _hashSource = {};
    _timerSource = {};
    _eventSource = {};
  }
}
