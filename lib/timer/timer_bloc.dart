import 'dart:async';

import 'package:rxdart/subjects.dart';
import 'package:timer_app/timer/timer_repo.dart';

class TimerBloc {
  // final TimeRepo _timeRepo = TimeRepo();
  // BehaviorSubject<int> timeBehavior = BehaviorSubject();
  // double time=0;
  //Stream<int> get timeStream => timeBehavior.stream;
  Stream<int> get timeStream => _controller.stream;
  StreamController<int> _controller = StreamController<int>();


  Future<void> setTime() async {
    // radius=radius!=0?radius:this.radius;
    //int time= _timeRepo.startTimer();
    int _start=60;
    const oneSec = const Duration(seconds: 1);
    await new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          _start=0;
          timer.cancel();
         // print(_start);
        } else {
          _start--;
          print(_start);
          _controller.add(_start);
        }
      },
    );
   // timeBehavior.sink.add(await _timeRepo.startTimer());
  }

}

class CountdownTimer {
  //final int _initialSeconds = 60;
  int _remainingSeconds = 60;
  late Timer _timer;
  StreamController<int> _controller = StreamController<int>();

  Stream<int> get stream => _controller.stream;

  CountdownTime() {
    _timer = Timer.periodic(Duration(seconds: 1), _tick);
  }

  void _tick(Timer timer) {
    if (_remainingSeconds > 0) {
      _remainingSeconds--;
      print(_remainingSeconds);
      _controller.add(_remainingSeconds);
    } else {
      _timer.cancel();
      _controller.close();
    }
  }

}