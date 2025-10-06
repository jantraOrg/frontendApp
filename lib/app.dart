import 'package:flutter/material.dart';
import 'routes.dart';

class JantraApp extends StatelessWidget {
  const JantraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Jantra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/intro',
      routes: appRoutes,
    );
  }
}
