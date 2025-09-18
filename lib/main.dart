import 'package:flutter/material.dart';
import 'package:omer_ahmed_mentorship/screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title: "Smart Ahwa Manager",
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'Arial'
      ),
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}