import 'package:flutter/material.dart';

import 'package:farmacia/bd/mongodb.dart';
import 'pages/usuarios/routes/routes.dart';

void main() async {
  await MongoDB.conectar();
  runApp(const MyApp());
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
