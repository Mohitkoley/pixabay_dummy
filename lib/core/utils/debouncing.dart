//create debouncing class
import 'dart:async';

class Debouncing {
  final int milliseconds;
  Timer? _timer;

  Debouncing({this.milliseconds = 800});

  run(void Function() action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
