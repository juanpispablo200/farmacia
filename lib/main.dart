import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/routes/routes.dart';
import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/pages/login_page.dart';

void main() async {
  await MongoDB.conectar();
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: 'welcome',
      debugShowCheckedModeBanner: false,
    );
  }
}
