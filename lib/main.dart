/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer_app/timer/timer_bloc.dart';
import 'package:timer_app/timer/timer_repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyTimerPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyTimerPage extends StatefulWidget {
  const MyTimerPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyTimerPage> createState() => _MyTimerPageState();
}

class _MyTimerPageState extends State<MyTimerPage> {
  late Timer _timer;
  int _start = 10;
  TimerBloc timerBloc=TimerBloc();
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          print('set to zero');
          //timerBloc.setTime(0);
          _timer.cancel();
        } else {
          _start--;
         // timerBloc.setTime(_start);
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Timer test")),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              //timerBloc.setTime();
             // timerBloc.startTimer();
             // TimeRepo timeRepo=TimeRepo();
             // CountdownTimer count=CountdownTimer();
              //count.CountdownTime();
              timerBloc.setTime();
            },
            child: Text("start"),
          ),
         // Text("$_start"),
          StreamBuilder<int>(
              stream: timerBloc.timeStream,
              builder: (context, snapshot) {
                return Text(snapshot.data==null?"60": snapshot.data!.toString(),style: TextStyle(fontSize: 30),);

              }
          ),
        ],
      ),
    );
  }
}

*/

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:timer_app/utility/app_theme.dart';

import 'library/book_read_screen.dart';

//void main() => runApp(const MyApp());
// void main() => runApp(
//   DevicePreview(
//     enabled: false,
//     builder: (context) => MyApp(), // Wrap your app
//   ),
// );

void main() {
  runApp(
     //ChangeNotifierProvider(create: (context) => DarkMode(), child: ThemeDemo()),
    //TimerServiceProvider(service: TimerService(), child: MaterialApp(home:MgActivityDetector(onShouldNavigate: (BuildContext ) {  },)))
   //  MyTimerApp()
      MaterialApp(home:ReadScreen())
  );

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ShowCase Demo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ShowCaseWidget(
          builder: Builder(builder: (context) => const ShowcaseDemo()),
        ),
      ),
    );
  }
}

class ShowcaseDemo extends StatefulWidget {
  const ShowcaseDemo({Key? key}) : super(key: key);

  @override
  _ShowcaseDemoState createState() => _ShowcaseDemoState();
}

class _ShowcaseDemoState extends State<ShowcaseDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _first = GlobalKey();
  final GlobalKey _second = GlobalKey();
  final GlobalKey _third = GlobalKey();
  final GlobalKey _fourth = GlobalKey();
  final GlobalKey _fifth = GlobalKey();

  @override
  void initState() {
    super.initState();
    //showCase();
    WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context)
          .startShowCase([_first, _second, _third, _fourth, _fifth]),);
    //       (_)  async {
    // await Future.delayed(Duration(milliseconds: 1200));
    // ShowCaseWidget.of(context).startShowCase([_first, _second, _third, _fourth, _fifth]);
    // },
    //);
  }
  Future showCase() async {
    await Future.delayed(Duration(seconds: 5),(){

    ShowCaseWidget.of(context).startShowCase([_first, _second, _third, _fourth, _fifth]);
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: Showcase(
          key: _first,
          description: 'Press here to open drawer',
          child: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        ),
        actions: [
          Showcase(
              key: _third,
              description: 'Press to see notification',
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_active)))
        ],
        title: Showcase(
            key: _second,
            description: 'This is a demo app title',
            child: const Text('Flutter Showcase Demo')),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
      Expanded(
      child: ListView(
        shrinkWrap: true,
        children:  <Widget>[
        Center(
        child: Showcase(
          key: _fourth,
          description:
          'FlutterDevs specializes in creating cost-effective and efficient applications',
          child: Container(
            //"assets/logo.png",
            height: 400,
            width: 350,
            color: Colors.green,
          )),
            ),
        ],
      ),
      )
        ],
      ),
      floatingActionButton: Showcase(
        key: _fifth,
        title: 'Add Image',
        description: 'Click here to add new Image',
        //shapeBorder: const CircleBorder(),
        child: FloatingActionButton(
          backgroundColor: Colors.cyan,
          onPressed: () {},
          child: const Icon(
            Icons.image,
          ),
        ),
      ),
    );
  }
}