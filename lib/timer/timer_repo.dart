

import 'dart:async';

class TimeRepo {
  int _start = 10;
  Future<int> startTimer() async {
    const oneSec = const Duration(seconds: 1);
    await new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          _start=0;
          timer.cancel();
          print(_start);
        } else {
            _start--;
            print(_start);
        }
      },
    );
    return _start;
  }
}
