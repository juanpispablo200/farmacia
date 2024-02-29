import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/routes/routes.dart';
import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDB.conectar();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? darkModeOn = prefs.getBool('darkMode');
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: MyApp(
      darkModeOn: darkModeOn,
    ),
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  final bool? darkModeOn;
  const MyApp({Key? key, required this.darkModeOn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
            backgroundColor: Colors.white),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
        ),
      ),
      themeMode: (darkModeOn ?? false) ? ThemeMode.dark : ThemeMode.light,
      routes: routes,
      initialRoute: 'welcome',
      debugShowCheckedModeBanner: false,
    );
  }
}
