/*import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class MyFlutterApp extends StatelessWidget {
  MyFlutterApp({Key? key}) : super(key: key);
  final mainTheme = ThemeData.light();
  final darkTheme = ThemeData.dark();


  @override
  Widget build(BuildContext context) {

    final themeMode = Provider.of<DarkMode>(context);


    return MaterialApp(
      home: const _MyApp(),
      theme: themeMode.darkMode ? darkTheme : mainTheme,
    );
  }
}

class _MyApp extends StatefulWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  State<_MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<DarkMode>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body:Settings()
    );
  }
}


class DarkMode with ChangeNotifier {
  bool darkMode = true; ///by default it is true
  ///made a method which will execute while switching
  changeMode() {
    darkMode = !darkMode;
    notifyListeners(); ///notify the value or update the widget value
  }
}

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: const _Settings(),
    );
  }
}

class _Settings extends StatefulWidget {
  const _Settings({Key? key}) : super(key: key);

  @override
  State<_Settings> createState() => _SettingsState();
}

class _SettingsState extends State<_Settings> {
  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<DarkMode>(context);
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              ListTile(
                leading: themeMode.darkMode?const Icon(Icons.dark_mode, size: 35):const Icon(Icons.light_mode, size: 35),
               // title: const Text("Dark Mode" ),
                title: themeMode.darkMode?Text("Dark Mode"):Text("Light Mode"),
                subtitle: const Text("Here you can change your theme."),
                trailing: Switch(
                  value: themeMode.darkMode,
                  activeTrackColor: const Color.fromARGB(255, 89, 216, 255),
                  activeColor: const Color.fromARGB(255, 78, 76, 175),
                  onChanged: (value) {
                    themeMode.changeMode();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}