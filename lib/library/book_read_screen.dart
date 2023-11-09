

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

const _inactivityTimeout = Duration(seconds: 10);
Timer? _keepAliveTimer;

void _keepAlive(bool visible) {
  _keepAliveTimer?.cancel();
  if (visible) {
    _keepAliveTimer = null;
  } else {
    _keepAliveTimer = Timer(_inactivityTimeout, () => exit(0));
  }
}

class _KeepAliveObserver extends WidgetsBindingObserver {
  @override didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state) {
      case AppLifecycleState.resumed:
        _keepAlive(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _keepAlive(false);  // Conservatively set a timer on all three
        break;
    }
  }
}

/// Must be called only when app is visible, and exactly once
void startKeepAlive() {
  assert(_keepAliveTimer == null);
  _keepAlive(true);
  WidgetsBinding.instance.addObserver(_KeepAliveObserver());
}






class TimerServiceProvider extends InheritedWidget{
  final TimerService _service;
  const TimerServiceProvider({
    Key? key,
    required TimerService service,
    required Widget child
  }):
  _service=service,
  super(key:key,child: child);

  @override
  bool updateShouldNotify(TimerServiceProvider old) => _service !=old._service;
}


class TimerService extends ChangeNotifier{
  Timer? _timer;
  Duration get currentDuration=>_currentDuration;
  Duration _currentDuration=Duration.zero;

  bool get isRunning=>_timer!=null;

  void _logOut(Timer timer){
    stop();
    notifyListeners();
  }

  void start(){
    if(_timer!=null)return;

    _timer=Timer.periodic(Duration(minutes: 3),_logOut);
    print(_timer.toString());
  }

  void stop(){
    _timer?.cancel();
    _timer=null;
  }

  void reset(){
    stop();
    start();
  }

  static TimerService of(BuildContext context){
    final TimerServiceProvider? provider=context.dependOnInheritedWidgetOfExactType<TimerServiceProvider>();
    return provider!._service;
  }
}

class MgActivityDetector extends StatefulWidget {
  final Function(BuildContext) _onShouldNavigate;
  final Widget? _child;

  const MgActivityDetector({
    Key? key,
    Widget? child,
    required Function(BuildContext) onShouldNavigate
  }) : _child=child,
      _onShouldNavigate=onShouldNavigate,
      super(key: key);

  @override
  State<MgActivityDetector> createState() => _MgActivityDetectorState();
}

class _MgActivityDetectorState extends State<MgActivityDetector> {
  TimerService? _timerService;
  
  @override
  Widget build(BuildContext context) {
    
    if(_timerService==null){
      _timerService=TimerService.of(context);
      _timerService!.start();
      _timerService!.addListener(_handleTimerNotifier);
    }
    
    return GestureDetector(
      onTap: _handleUserInteraction,
      child:Text(TimerService.of(context).currentDuration.toString())
    );
  }
  void _handleUserInteraction([_]){
    _timerService!.reset();
  }

  void _handleTimerNotifier(){
    widget._onShouldNavigate(context);
  }
}





const timeout = const Duration(seconds: 10);
const ms = const Duration(milliseconds: 1);
Timer? timer;


class MyTimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var home = MyHomePage(title: 'Flutter Demo Home Page');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: home,
    );
  }


}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _goToSecondScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SecondPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToSecondScreen,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    ), behavior:
    HitTestBehavior.translucent, onTapDown: (tapdown) {
      print("down");
      if (timer != null) {
        timer!.cancel();
      }
      timer = startTimeout();
    },);
  }

  startTimeout([int? milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScreenSaver()),
    );
  }

}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}
class ScreenSaver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(child:Container(color: Colors.yellow,),
      onTap: (){
        Navigator.pop(context);
      },
    );
  }
}



class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  Timer? timer1;
  Timer? timer2;
  int seconds=0;
  @override
  void initState() {
    startTimer1();
    startTimer();
    // timer2=Timer.periodic(
    //   const Duration(seconds: 1),
    //       (timer) {
    //     // Update user about remaining time
    //         print("timer2!.tick ${timer2!.tick}");
    //         if(timer2!.tick==10){
    //           timer1!.cancel();
    //         }
    //   },
    // );

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: (){
     //if(timer2!.isActive) startTimer();
     if(timer2!.tick>20){
       startTimer();
       startTimer1();
     }
     else{
       startTimer1();
     }
    },
      child: Text("${timer2!.tick}  ${timer1!.tick}"),
    );
  }

  void startTimer(){
    //timer2!.cancel();
    timer2= new Timer.periodic(Duration(seconds: 1), (timer) {
      print("In T  timer2!.tick ${timer2!.tick}");
      //print("timer1!.tick ${timer1!.tick}");
      if(timer2!.tick==20){
        timer1!.cancel();
      }

    });
  }
  void startTimer1(){
    timer1= new Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        print("In T1  timer1!.tick ${timer1!.tick}");
        if(seconds!=100) {
          seconds++;
          print("seconds $seconds");
        }else{
          timer1!.cancel();
          print("Time's up");
        }
      },
    );
  }
}
