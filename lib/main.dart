import 'package:flutter/material.dart';
import 'package:travenor_app/Auth/view/pages/Splash.dart';
import 'package:travenor_app/Auth/view/pages/view_page.dart';
import 'package:travenor_app/Auth/view/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ViewPage(),
      ),
    );
  }
}
