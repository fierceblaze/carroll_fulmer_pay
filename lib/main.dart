import 'package:flutter/material.dart';

import 'screens/HomePage.dart';

void main() {
  //runApp(Text("Hello World.", textDirection: TextDirection.ltr));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String appTitle = 'Carroll Fulmer Pay Calculator';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // useMaterial3: true,
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: appTitle),
    );
  }
}
